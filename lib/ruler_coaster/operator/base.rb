module RulerCoaster
  module Operator
    class Base
      attr_reader :assert_value,
                  :value_type

      def initialize(value, value_type = nil)
        @value_type = infere_value_type(value_type, value)
        @assert_value = build_term(value, @value_type).value
      end

      protected

      def term_for(value)
        Term.call(value, @value_type).value
      end

      private

      def build_term(value, value_type)
        value.is_a?(Term::Base) ? value : Term.call(value, value_type)
      end

      def infere_value_type(type, value)
        mapping = {
          String => 'string',
          Fixnum => 'number',
          Float => 'decimal',
          Array => 'array'
        }

        return mapping[value.class] || 'string' if type.nil?

        type
      end
    end
  end
end

require 'ruler_coaster/operator/contain'
require 'ruler_coaster/operator/empty'
require 'ruler_coaster/operator/equal'
require 'ruler_coaster/operator/greater_than'
require 'ruler_coaster/operator/less_than'
require 'ruler_coaster/operator/not_contain'
require 'ruler_coaster/operator/not_empty'
require 'ruler_coaster/operator/not_equal'
