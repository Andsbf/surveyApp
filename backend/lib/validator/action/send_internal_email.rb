module Validator
  module Action
    class SendInternalEmail < Base
      def valid?
        super && hyper_valid?
      end

      def hyper_valid?
        arguments_valid?
      end

      private

      def arguments_valid?
        arguments.wishmail.present? &&
        arguments.emails.present?
      end
    end
  end
end
