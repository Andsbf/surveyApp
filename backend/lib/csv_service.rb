require 'csv'

class CSVService
  EXPORT_BUCKET_NAME = 'pandabot.csv.exports'.freeze
  EMAIL_KEY = 'email'.freeze

  NoHeadersError = Class.new(StandardError)

  def initialize(integration_list)
    @integration_list = integration_list
  end

  def fields
    import_headers.map do |header|
      { name: header, key: header }
    end
  end

  def leads(uniq_key = nil)
    rows = import_csv_table.select { |row| row.to_a.flatten.any? }
    rows = rows.uniq { |row| row[uniq_key] } if uniq_key
    rows.map { |row| format_attributes(row) }
  end

  def export_leads(leads, export)
    key = generate_export_key(export)
    filename = generate_export_filename(key)
    headers = export_headers(export.integration_key_mappings)

    generate_export_csv(filename, headers, leads)

    s3_object = upload_export(filename, export, key)
    WishpondHookWorker.perform_async(export.merchant_id, s3_object.public_url)

    export.update_attribute(:status, 'completed')
  end

  private

  def upload_export(filename, export, key)
    service = S3Service.new(merchant: export.merchant, bucket_name: EXPORT_BUCKET_NAME)

    service.upload(
      filename,
      key: key,
      upload_options: {
        acl: 'public-read'.freeze,
        content_type: 'application/CSV'.freeze,
        content_disposition: "attachment; filename=#{key}"
      }
    )
  end

  def generate_export_csv(filename, headers, leads)
    CSV.open(filename, 'w') do |csv|
      csv << headers.map(&:titleize)

      leads.each do |lead|
        csv << headers.map { |header| lead[header] }
      end
    end
  end

  def export_headers(mappings)
    mappings.map { |mapping| mapping.key }.tap do |headers|
      headers.sort!
      headers.unshift(headers.delete(EMAIL_KEY)) if headers.include?(EMAIL_KEY)
    end.uniq
  end

  def generate_export_filename(key)
    "#{Rails.root}/tmp/#{key}"
  end

  def generate_export_key(export)
    "#{SecureRandom.hex(8)}_#{Time.now.to_i}_lead_export".tap do |name|
      name << "_#{export.source[:name].parameterize.underscore}" if export.source.present?

      if title = campaign_title(export)
        name << "_#{title}"
      end

      name << '.csv'.freeze
    end
  end

  def campaign_title(export)
    requirement = export.campaign_requirement

    if requirement
      title = requirement.extras['title'.freeze]
      title.parameterize.underscore if title
    end
  end

  def format_attributes(hash)
    cleaned =
      hash.reject do |key, value|
        key.nil? || value.nil?
      end

    { 'attributes'.freeze => Hash[cleaned] }
  end

  def import_headers
    return @integration_list.headers if @integration_list.headers

    if parsed_import_headers.blank?
      raise NoHeadersError
    else
      @integration_list.update_attribute(:headers, parsed_import_headers)
      parsed_import_headers
    end
  end

  def parsed_import_headers
    @parsed_import_headers ||=
      import_csv_table.headers.map do |header|
        header.to_s.strip.presence
      end.compact
  end

  def import_csv_table
    import_csv.gsub!("\r","\n") if import_csv.include?("\r") && !import_csv.include?("\r\n")
    CSV::parse(import_csv, headers: true, skip_blanks: true)
  end

  def import_csv
    @csv ||= format_csv
  end

  def format_csv
    encoded_csv = force_encoding(fetch_csv)
    remove_invalid_chars(encoded_csv)
  end

  def fetch_csv
    S3Service.new.get_object(@integration_list.upload_key).body.read
  end

  def force_encoding(csv)
    csv.force_encoding('ISO-8859-1'.freeze)
  end

  def remove_invalid_chars(csv)
    csv.encode(Encoding::UTF_8, { invalid: :replace, undef: :replace, replace: '' })
  end
end
