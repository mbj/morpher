# encoding: utf-8

require 'devtools/spec_helper'
require 'morpher'
require 'mutant' # for the node helpers

# Monkeypatch to mutant .rc3 fixing double diffs error.
#
# Also does run all mutations.
#
# TODO: Use master once it supports configurable implicit coverage.
#
# Morpher predicates are needed to finally make this configurable in mutant.
#
module Mutant
  class Subject
    class Method
      class Instance
        class Memoized

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

  class Killer
    class Rspec

      # Return all example groups
      #
      # @return [Enumerable<RSpec::Example>]
      #
      # @api private
      #
      def example_groups
        strategy.example_groups
      end

    end # Rspec
  end # Killer
end # Mutant

RSpec.configure do |config|
  config.include(StripHelper)
  config.include(Morpher::NodeHelpers)
  config.expect_with :rspec do |rspec|
    rspec.syntax = [:expect, :should]
  end
end
