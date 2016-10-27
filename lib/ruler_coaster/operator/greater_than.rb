module RulerCoaster
  module Operator
    class GreaterThan < Base
      def call(value)
        term_for(value) > assert_value
      end
    end
  end
end
