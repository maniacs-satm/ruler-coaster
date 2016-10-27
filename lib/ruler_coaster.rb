require 'ruler_coaster/parser'
require 'ruler_coaster/term/base'
require 'ruler_coaster/operator/base'
require 'ruler_coaster/logic/base'
require 'ruler_coaster/rule'
require 'ruler_coaster/result'
require 'ruler_coaster/no_result'
require 'ruler_coaster/attributes/base'

module RulerCoaster
  class NavigationError < StandardError; end

  extend Parser
end
