module Validator
  module Action
    class AddRemoveList < Base
      def valid?
        super && hyper_valid?
      end

      def hyper_valid?
        arguments_valid?
      end

      private

      def arguments_valid?
        arguments.action.present? &&
        arguments.list_id.present?
      end
    end
  end
end
