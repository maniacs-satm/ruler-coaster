module RulerCoaster
  module Operator
    class Contain < Base
      def call(value)
        assert_value.map(&:to_s).map(&:downcase).include?(value.to_s.downcase)
      end
    end
  end
end
