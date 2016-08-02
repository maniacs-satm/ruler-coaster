require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start

require 'simplecov'

SimpleCov.start do
  formatter SimpleCov::Formatter::MultiFormatter.new [
    SimpleCov::Formatter::HTMLFormatter,
    CodeClimate::TestReporter::Formatter
  ]
end

require 'pry'
require 'ruler'
require_relative 'support/node_helpers'

RSpec.configure do |config|
  config.include NodeHelpers
end
