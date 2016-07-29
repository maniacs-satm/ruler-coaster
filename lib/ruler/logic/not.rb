module Ruler
  module Logic

    class Not < Base

      def call(object)
        result = left.(object)

        if result.success?
          right.(object).negation
        else
          result.negation
        end
      end

    end

  end
end
