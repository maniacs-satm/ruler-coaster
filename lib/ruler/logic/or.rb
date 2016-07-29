module Ruler
  module Logic

    class Or < Base

      def call(object)
        result = left.(object)

        unless result.success?
          right.(object)
        else
          result
        end
      end

    end

  end
end
