module Validator
  module Action
    class IntegrationAction < Base
      def valid?
        super && hyper_valid?
      end

      def hyper_valid?
        arguments_valid?
      end

      private

      def arguments_valid?
        arguments.key.present? &&
        arguments.integration_id.present? &&
        arguments.connection_id.present? &&
        arguments.params.present?
      end
    end
  end
end
