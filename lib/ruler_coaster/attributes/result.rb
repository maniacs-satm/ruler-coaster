module RulerCoaster
  module Attributes
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
        @errors.keys.empty? && @blocked.empty?
      end
    end
  end
end
