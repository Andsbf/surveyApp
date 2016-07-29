module Validator
  module Action
    class Webhook < Base
      URL_REGEX = /\A(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,63}(:[0-9]{1,5})?(\/.*)?\z/ix

      def valid?
        super && hyper_valid?
      end

      def hyper_valid?
        arguments_valid? && url_valid?
      end

      private

      def arguments_valid?
        arguments.url.present?
      end

      def url_valid?
        !!arguments.url.match(URL_REGEX)
      end
    end
  end
end
