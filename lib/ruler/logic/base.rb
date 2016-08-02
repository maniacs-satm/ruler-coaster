require 'ruler/logic/mixin'

module Ruler
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

require 'ruler/logic/and'
require 'ruler/logic/or'
require 'ruler/logic/not'
require 'ruler/logic/nor'
