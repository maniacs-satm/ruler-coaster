module Ruler
  module Logic

    class Nor < Base

      def call(object)
        result = left.(object)

        unless result.success?
          right.(object).negation
        else
          result.negation
        end
      end

    end

  end
end
