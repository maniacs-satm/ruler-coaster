module RulerCoaster
  module Term
    def self.call(value, value_type = nil)
      mapping = {
        'string' => Term::String,
        'number' => Term::Number,
        'decimal' => Term::Decimal,
        'array' => Term::Array,
        'array[string]' => Term::Array,
        'array[number]' => Term::ArrayNumber,
        'array[decimal]' => Term::ArrayDecimal
      }

      (mapping[value_type] || Term::String).new(value)
    end

    class Base
      attr_accessor :value

      def initialize(value)
        @value = value
      end
    end
  end
end

require 'ruler_coaster/term/string'
require 'ruler_coaster/term/number'
require 'ruler_coaster/term/decimal'
require 'ruler_coaster/term/array'
