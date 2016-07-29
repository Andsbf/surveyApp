module Validator
  module Action
    class Base
      def initialize(action)
        @action = action
      end

      def arguments
        OpenStruct.new(@action.arguments)
      end

      def valid?
        base_valid? && schedule_valid?
      end

      def base_valid?
        ::Action::VALID_TYPES.include?(type)
      end

      def schedule_valid?
        if scheduled_time.present?
          scheduled_time > Time.now.utc.to_i
        else
          true
        end
      end

      private

      # Delegate methods called on this object to the action
      def method_missing(name, *args, &block)
        if @action.respond_to?(name.to_sym)
          @action.send(name, *args, &block)
        else
          super
        end
      end

      def respond_to?(name)
        if @action.respond_to?(name)
          true
        else
          super
        end
      end
    end
  end
end
