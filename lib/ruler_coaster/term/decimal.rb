module RulerCoaster
  module Term
    class Decimal < Base
      def value
        @value.to_f
      end
    end
  end
end
