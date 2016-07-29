class LeadExporter

  def self.export_leads(export, leads)
    export_leads =
      leads.map do |lead_hash|
        lead = ExportLead.new(export, lead_hash.attributes)
        lead.process_export if lead.valid?
      end.compact

    # There may be no valid leads in this batch. If so, don't attempt to export.
    Exporter.new(export_leads, export).export_batch if export_leads.any?
  end

  class ExportLead
    def initialize(export, data)
      @export = export
      @email = data["email"]
      @raw_attributes = data
    end

    def format_raw_attributes(data)
      formatted_data = data.dup
      formatted_data.merge!(formatted_data.delete('dynamic_attributes'))
      formatted_data
    end

    def map_attributes(data)
      @export.integration_key_mappings.each_with_object({}) do |key_map, mapped_data|
        mapped_data[key_map.integration_key] = data[key_map.key] if data[key_map.key]
      end
    end

    def process_export
      map_attributes(format_raw_attributes(@raw_attributes))
    end

    def valid?
      if @export.csv?
        true
      else
        @email.present?
      end
    end
  end

  class Exporter
    def initialize(leads, export)
      @leads  = leads
      @export = export
    end

    def export_batch
      # This means they deleted the integration list. We can't do anything from there.
      return if @export.destination.nil?

      @export.destination.export_leads(@leads, @export)
      @export.inc(count: @leads.count)
    end
  end

end
