module RulerCoaster
  module Operator
    class NotContain < Contain
      def call(value)
        !super
      end
    end
  end
end
