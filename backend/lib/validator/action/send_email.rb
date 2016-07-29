module Validator
  module Action
    class SendEmail < Base
      def valid?
        super && hyper_valid?
      end

      def hyper_valid?
        arguments_valid? && wishmail_arguments_valid? && wishmails_valid?
      end

      private

      def arguments_valid?
        arguments.type.present?
      end

      def wishmail_arguments_valid?
        arguments.wishmails.present? &&
        arguments.wishmails.length > 0
      end

      def wishmails_valid?
        arguments.wishmails.all? do |wishmail|
          wishmail['id'].present? && wishmail['name'].present?
        end
      end
    end
  end
end
