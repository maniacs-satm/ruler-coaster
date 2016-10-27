module RulerCoaster
  module Term
    class Array < Base
      def value
        array_value.map(&:to_s).map(&:strip)
      end

      protected

      def array_value
        @value.is_a?(::Array) ? @value : @value.split(',')
      end
    end

    class ArrayNumber < Term::Array
      def value
        array_value.map do |item|
          item.to_s.strip.to_i
        end
      end
    end

    class ArrayDecimal < Term::Array
      def value
        array_value.map do |item|
          item.to_s.strip.to_f
        end
      end
    end
  end
end
