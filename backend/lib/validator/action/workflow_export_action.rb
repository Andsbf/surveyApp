module Validator
  module Action
    class WorkflowExportAction < Base
      def valid?
        super && hyper_valid?
      end

      def hyper_valid?
        arguments_valid? && export_valid? && key_mappings_valid?
      end

      private

      def key_mappings
        arguments.keyMappings
      end

      def arguments_valid?
        arguments.integration_platform.present? &&
        arguments.connection_id.present? &&
        arguments.list_id.present? &&
        arguments.export_id.present?
      end

      def export_valid?
        export.present? &&
        export.destination.present? &&
        export.integration_key_mappings.present?
      end

      def key_mappings_valid?
        key_mappings.present? && all_keys_present? && email_key_present?
      end

      def all_keys_present?
        key_mappings.all? { |keymap| keymap['key'].present? && keymap['integrationKey'].present? }
      end

      def email_key_present?
        key_mappings.any? { |key_map| key_map['key'] == 'email' }
      end
    end
  end
end

