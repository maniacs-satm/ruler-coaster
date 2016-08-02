module Ruler
  module Logic

    class Nor < Base

      def call(object)
        result = left.call(object)

        if !result.success?
          right.call(object).negation
        else
          result.negation
        end
      end

    end

  end
end
