require "ruler/coaster/result"

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

        rules.each do |attr, attr_rules|
          attr_rules.each do |rule|
            result = rule.(object)

            if result.is_a?(NoResult)
              blocked = block(blocked, attr)
            elsif !result.success?
              errors = hell(errors, attr, "is invalid")
            end
          end
        end

        Ruler::Coaster::Result.new(rules, object, errors, blocked)
      end

      def hell(errors, attr, message)
        attr_errors = errors[attr] ||= []

        unless attr_errors.include?(message)
          attr_errors << "is invalid"
        end

        errors[attr] = attr_errors
        errors
      end

      def block(blocked, attr)
        unless blocked.include?(attr)
          blocked << attr
        end

        blocked
      end

    end

  end

end
