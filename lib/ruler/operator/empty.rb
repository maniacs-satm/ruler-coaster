module Ruler
  module Operator

    class Empty < Base

      def initialize(*args)
        super(nil)
      end

      def call(value)
        value.to_s.length == 0
      end

    end

  end
end
