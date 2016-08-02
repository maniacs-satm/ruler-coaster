module RulerCoaster
  module Operator
    class Base
      attr_reader :assert_value

      def initialize(assert_value)
        @assert_value = assert_value
      end
    end
  end
end

require 'ruler_coaster/operator/contain'
require 'ruler_coaster/operator/empty'
require 'ruler_coaster/operator/equal'
require 'ruler_coaster/operator/greater_than'
require 'ruler_coaster/operator/less_than'
require 'ruler_coaster/operator/not_contain'
require 'ruler_coaster/operator/not_empty'
require 'ruler_coaster/operator/not_equal'
