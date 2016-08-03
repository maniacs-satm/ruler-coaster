module RulerCoaster
  module Operator
    class Equal < Base
      def call(value)
        assert_value.to_s.casecmp(value.to_s) == 0
      end
    end
  end
end
