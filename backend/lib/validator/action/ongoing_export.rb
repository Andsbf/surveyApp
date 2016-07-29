module Validator
  module Action
    class OngoingExport < Base
      def valid?
        super && hyper_valid?
      end

      def hyper_valid?
        true
      end
    end
  end
end
