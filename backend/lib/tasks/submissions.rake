namespace :submissions do
  desc 'Update submissions with default form fields'
  task update_predefined_fields: :environment do

    directory_name = "/tmp/submissions_updater_log"
    Dir.mkdir(directory_name) unless File.exists?(directory_name)
    batch_size = ENV["BATCH_SIZE"] || 1_000
    version = ENV["VERSION"]

    if version.blank?
      raise "A version file is needed. Either v1 or v2."
    end

    log_file = File.open("#{directory_name}/#{version}", "w+")

    Dir.open("/tmp/variation_form_fields_#{version}").each do |file_dir|
      next if file_dir == '.' || file_dir == '..'

      File.open("/tmp/variation_form_fields_#{version}/#{file_dir}", "r") do |file|
        file.each_line do |line|

          json = JSON.parse(line)

          Submission.where(mid: json["mid"].to_s, variation_id: json["variation_id"].to_s)
            .find_in_batches(batch_size: batch_size) do |batch|

              submissions = batch.to_a

              Lead.where(mid: json["mid"].to_s, :cid.in => submissions.map(&:cid)).each do |lead|
                log_file.puts "New Lead: #{lead.email}"
                current_submissions = submissions.select { |sub| sub.cid == lead.cid && sub.mid.to_s == lead.mid.to_s }

                current_submissions.each do |sub|
                  form_data = sub.form_data
                  updated = false

                  log_file.puts "Before: #{form_data}"

                  json["fields"].each do |field|
                    field_key = field["key"]

                    # No value in submission and we have it in lead.
                    if form_data[field_key].blank? && lead.dynamic_attributes[field_key].present?
                      updated = true

                      form_data[field_key] = {
                        "value" => lead.dynamic_attributes[field_key],
                        "input_type" => "text",
                        "name" => field["name"]
                      }

                    end
                  end

                  log_file.puts "After: #{form_data}"
                  sub.update_attributes(form_data: form_data) if ENV["EXECUTE"] && updated
                end
              end # lead

          end # submission
        end
      end

    end

    log_file.close
  end
end
