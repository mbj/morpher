# encoding: utf-8

if ENV['COVERAGE'] == 'true'
  require 'simplecov'
  require 'coveralls'

  SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter[
    SimpleCov::Formatter::HTMLFormatter,
    Coveralls::SimpleCov::Formatter
 ]

  SimpleCov.start do
    command_name 'spec:unit'

    add_filter 'config'
    add_filter 'spec'
    add_filter 'vendor'
    add_filter 'test_app'

    minimum_coverage 100  # TODO: raise this to 100, then mutation test
  end
end

require 'triage/spec_helper'
require 'ducktrap'
require 'mutant' # for the node helpers

RSpec.configure do |config|
  config.expect_with :rspec do |rspec|
    rspec.syntax = [:expect, :should]
  end
end
