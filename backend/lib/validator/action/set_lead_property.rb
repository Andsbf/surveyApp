module Validator
  module Action
    class SetLeadProperty < Base
      def valid?
        super && hyper_valid?
      end

      def hyper_valid?
        arguments_valid?
      end

      private

      def arguments_valid?
        arguments.action.present? &&
        arguments.lead_property.present? &&
        arguments.value.present?
      end
    end
  end
end
