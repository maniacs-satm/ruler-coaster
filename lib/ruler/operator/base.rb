module Ruler
  module Operator
    class Base
      attr_reader :assert_value

      def initialize(assert_value)
        @assert_value = assert_value
      end
    end
  end
end

require 'ruler/operator/contain'
require 'ruler/operator/empty'
require 'ruler/operator/equal'
require 'ruler/operator/greater_than'
require 'ruler/operator/less_than'
require 'ruler/operator/not_contain'
require 'ruler/operator/not_empty'
require 'ruler/operator/not_equal'
