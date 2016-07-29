module Validator
  module Action
    class Delay < Base
      def valid?
        super && hyper_valid?
      end

      def hyper_valid?
        delays_are_numerical? && delay_exists?
      end

      private

      def delay_exists?
        delay.values.any? { |interval| interval > 0 }
      end

      def delays_are_numerical?
        delay.values.all? { |interval| interval.is_a?(Integer) && interval >= 0 }
      end
    end
  end
end
