module Ruler
  module Operator
    class NotEmpty < Empty
      def call(value)
        !super(value)
      end
    end
  end
end
