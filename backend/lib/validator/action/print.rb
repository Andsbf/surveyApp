module Validator
  module Action
    class Print < Base
      def valid?
        super && hyper_valid?
      end

      def hyper_valid?
        arguments_valid?
      end

      private

      def arguments_valid?
        arguments.strings.present?
      end
    end
  end
end
