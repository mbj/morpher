require 'abstract_type'
require 'concord'
require 'anima'
require 'ast'

# Library namespace module
module Morpher

  # The node registry
  REGISTRY = {}

  EMPTY_ARRAY = [].freeze

  module Undefined
    freeze
  end

  # Return evaluator from node
  #
  # @param [Node]
  #
  # @return [Evaluator]
  #
  # @api private
  #
  def self.evaluator(node)
    Compiler.new(REGISTRY).call(node)
  end

end # Morpher

require 'morpher/node'
require 'morpher/node_helpers'
require 'morpher/printer'
require 'morpher/printer/mixin'
require 'morpher/evaluator'
require 'morpher/evaluator/nullary'
require 'morpher/evaluator/nary'
require 'morpher/evaluator/parameterized'
require 'morpher/evaluator/transformer'
require 'morpher/evaluator/transformer/block'
require 'morpher/evaluator/transformer/key'
require 'morpher/evaluator/transformer/anima'
require 'morpher/evaluator/transformer/guard'
require 'morpher/evaluator/transformer/hash_transform'
require 'morpher/evaluator/predicate'
require 'morpher/evaluator/predicate/eql'
require 'morpher/evaluator/predicate/primitive'
require 'morpher/evaluation'
require 'morpher/evaluation'
require 'morpher/type_lookup'
require 'morpher/compiler'
require 'morpher/compiler/preprocessor'
