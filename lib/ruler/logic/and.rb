module Ruler
  module Logic

    class And < Base

      def call(object)
        result = left.(object)

        if result.success?
          right.(object)
        else
          result
        end
      end

    end

  end
end
