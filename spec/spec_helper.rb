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
require 'morpher'
require 'mutant' # for the node helpers

# Monkeypatch to mutant .rc3 fixing double diffs error.
#
# TODO: Use master once it supports configurable implicit coverage.
#
module Mutant
  class Subject
    class Method
      class Instance

        # Return source
        #
        # @return [String]
        #
        # @api private
        #
        def source
          Unparser.unparse(memoizer_node(node))
        end
        memoize :source

      end
    end
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |rspec|
    rspec.syntax = [:expect, :should]
  end
end
