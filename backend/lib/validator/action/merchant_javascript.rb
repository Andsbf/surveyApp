module Validator
  module Action
    class MerchantJavascript < Base
      def valid?
        super && hyper_valid?
      end

      def hyper_valid?
        arguments_valid? && url_value_valid?
      end

      private

      def arguments_valid?
        arguments.url_match_type.present? &&
        arguments.javascript.present?
      end

      def url_value_valid?
        if arguments.url_match_type == 'isset'.freeze
          true
        else
          arguments.url_value.present?
        end
      end
    end
  end
end
