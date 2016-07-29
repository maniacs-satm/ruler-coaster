module Ruler
  module Operator

    class NotEqual < Equal

      def call(value)
        !super
      end

    end

  end
end
