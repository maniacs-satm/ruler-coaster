module RulerCoaster
  module Logic
    module Mixin
      def and(right)
        Logic::And.new(self, right)
      end

      def or(right)
        Logic::Or.new(self, right)
      end

      def not(right)
        Logic::Not.new(self, right)
      end

      def nor(right)
        Logic::Nor.new(self, right)
      end
    end
  end
end
