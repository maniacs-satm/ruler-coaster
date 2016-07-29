module Ruler
  module Operator

    class Equal < Base

      def call(value)
        assert_value.to_s.downcase == value.to_s.downcase
      end

    end

  end
end
