module RulerCoaster
  module Operator
    class Equal < Base
      def call(value)
        assert_value.to_s.casecmp(term_for(value).to_s) == 0
      end
    end
  end
end
