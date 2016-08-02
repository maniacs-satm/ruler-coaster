require 'pry'
require 'simplecov'
require 'codeclimate-test-reporter'

SimpleCov.start do
  formatter SimpleCov::Formatter::MultiFormatter.new [
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
  ]
end

require 'ruler'
require_relative 'support/node_helpers'

RSpec.configure do |config|
  config.include NodeHelpers
end
