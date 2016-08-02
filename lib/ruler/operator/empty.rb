module Ruler
  module Operator
    class Empty < Base
      def initialize(*_args)
        super(nil)
      end

      def call(value)
        value.to_s.empty?
      end
    end
  end
end
