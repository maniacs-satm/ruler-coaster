module RulerCoaster
  module Logic
    class Or < Base
      def call(object)
        result = left.call(object)

        if !result.success?
          right.call(object)
        else
          result
        end
      end
    end
  end
end
