require 'abstract_type'
require 'concord'
require 'anima'

# Library namespace module
module Morpher

  # The node registry
  REGISTRY = {}

  module Undefined

    def self.pretty_dump(printer)
      printer.puts(name)
    end

    freeze

  end

  def self.tracker(node)
    Compiler::Tracking::Root.new(REGISTRY).call(node)
  end

  def self.evaluator(node)
    Compiler::Evaluating.new(REGISTRY).call(node)
  end

end # Morpher

require 'morpher/compiler'
require 'morpher/evaluator'
require 'morpher/evaluator/nullary'
require 'morpher/evaluator/nary'
require 'morpher/printer'
require 'morpher/evaluation'
