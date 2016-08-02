require 'ruler/coaster/result'

module Ruler
  module Coaster
    class Base
      attr_reader :rules

      def initialize(rules)
        @rules = rules
      end

      def call(object)
        errors = {}
        blocked = []

        each_attr_rule_result(object) do |attr, result|
          if result.is_a?(Ruler::NoResult)
            blocked = block(blocked, attr)
          elsif !result.success?
            errors = hell(errors, attr, 'is invalid')
          end
        end

        Ruler::Coaster::Result.new(rules, object, errors, blocked)
      end

      private

      def each_attr_rule_result(object)
        rules.each do |attr, attr_rules|
          attr_rules.each do |rule|
            yield(attr, rule.call(object))
          end
        end
      end

      def hell(errors, attr, message)
        attr_errors = errors[attr] ||= []

        attr_errors << 'is invalid' unless attr_errors.include?(message)

        errors[attr] = attr_errors
        errors
      end

      def block(blocked, attr)
        blocked << attr unless blocked.include?(attr)
        blocked
      end
    end
  end
end
