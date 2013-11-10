require 'abstract_type'
require 'concord'

# Library namespace module
module Ducktrap

  # The node registry
  REGISTRY = {}

  def self.tracker(node)
    Compiler::Tracking::Root.new(REGISTRY).call(node)
  end

  def self.evaluator(node)
    Compiler::Evaluating.new(REGISTRY).call(node)
  end

end # Ducktrap

require 'ducktrap/tracker'
require 'ducktrap/compiler'
require 'ducktrap/evaluator'
