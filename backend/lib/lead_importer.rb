module LeadImporter

  def self.import_leads(import, leads)
    leads.each do |lead|
      ImportLead.new(import, lead).process_import
    end
    import.update_attribute(:status, "completed")
  end

  class ImportLead
    VALID_EMAIL_REGEX = /^[a-zA-Z0-9._%+-]+@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,6}$/i

    InvalidLead = Class.new(StandardError)

    def initialize(import, data)
      @import = import
      @attributes = data['attributes']
      @mapped_attributes = map_attributes(@attributes)
      @email = data['email'.freeze]

      # Here we are merging in the force mapped email from external integrations.
      # If we don't have that (CSV), then we search through the mapped attributes
      # for one. We will validate the format before importing.
      if @email
        @mapped_attributes.merge!('email'.freeze => @email)
      else
        @email = @mapped_attributes['email'.freeze]
      end

      @cid = find_cid
    end

    def validate!
      return :valid if mid && @cid.present? && valid_email?
      raise InvalidLead.new(@mapped_attributes)
    end

    def process_import
      validate!

      @mapped_attributes[:lists] = @import.destination_id if @import.destination_id

      Sentry::Handlers::Attribute.new(
        mid,
        @cid,
        @mapped_attributes,
        context: context,
        priority: :deferred,
        timestamp: Time.now
      ).track

      @import.inc(count: 1)
    rescue InvalidLead => e
      Rails.logger.error(e.message)
    end

    private

    def context
      if @import.destination_id
        { operation: :add }
      else
        {}
      end
    end

    def map_attributes(data)
      @import.integration_key_mappings.each_with_object({}) do |key_map, mapped_data|
        mapped_data[key_map.key] = data[key_map.integration_key] if data[key_map.integration_key].present?
      end
    end

    def mid
      @import.merchant.id
    end

    def find_cid
      @attributes['cid'.freeze] || fetch_cid_by_email || create_new_cid
    end

    def fetch_cid_by_email
      UserAttribute.where(mid: mid, key: :email, value: @email).first.try(:cid)
    end

    def create_new_cid
      SecureRandom.hex(8)
    end

    def valid_email?
      @email.present? && @email =~ VALID_EMAIL_REGEX
    end
  end
end
