module RulerCoaster
  module Operator
    class Base
      attr_reader :assert_value

      def initialize(value, value_type = nil)
        @assert_value = \
          build_term(value, infere_value_type(value_type, value)).value
      end

      private

      def build_term(value, value_type)
        value.is_a?(Term::Base) ? value : Term.(value, value_type)
      end

      def infere_value_type(type, value)
        mapping = {
          String => 'string',
          Fixnum => 'number',
          Float => 'decimal',
          Array => 'array'
        }

        if type.nil?
          mapping[value.class] || 'string'
        else
          type
        end
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
