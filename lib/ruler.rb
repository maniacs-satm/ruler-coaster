require "ruler/parser"
require "ruler/operator/base"
require "ruler/logic/base"
require "ruler/rule"
require "ruler/result"
require "ruler/no_result"
require "ruler/coaster/base"

module Ruler

  class NavigationError < StandardError; end

  extend Parser

end

