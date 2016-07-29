module Ruler
  module Operator

    class LessThan < GreaterThan

      def call(value)
        !super
      end

    end

  end
end
