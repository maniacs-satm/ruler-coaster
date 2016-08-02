require 'ruler_coaster/logic/mixin'

module RulerCoaster
  module Logic
    class Base
      include Mixin

      attr_reader :left,
                  :right

      def initialize(left, right)
        @left = left
        @right = right
      end
    end
  end
end

require 'ruler_coaster/logic/and'
require 'ruler_coaster/logic/or'
require 'ruler_coaster/logic/not'
require 'ruler_coaster/logic/nor'
