module RulerCoaster
  module Term
    class Number < Base
      def value
        @value.to_i
      end
    end
  end
end
