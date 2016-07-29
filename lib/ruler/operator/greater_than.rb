module Ruler
  module Operator

    class GreaterThan < Base

      def call(value)
        value > assert_value
      end

    end

  end
end
