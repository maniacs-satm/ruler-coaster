module Ruler
  module Coaster

    class Result

      attr_reader :rules,
                  :input,
                  :errors,
                  :blocked

      def initialize(rules, input, errors, blocked = {})
        @rules = rules
        @input = input
        @errors = errors
        @blocked = blocked
      end

      def success?
        @errors.keys.length == 0 && @blocked.length == 0
      end

    end

  end

end
