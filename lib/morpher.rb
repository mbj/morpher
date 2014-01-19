# encoding: UTF-8

require 'abstract_type'
require 'concord'
require 'anima'
require 'ast'

# Library namespace module
module Morpher

  EMPTY_ARRAY = [].freeze

  Undefined = Module.new.freeze

  # Return evaluator from node
  #
  # @param [Node]
  #
  # @return [Evaluator]
  #
  # @api private
  #
  def self.evaluator(node)
    node = Preprocessor.new(Emitter::REGISTRY).call(node)
    Compiler.new(Evaluator::REGISTRY).call(node)
  end

end # Morpher

require 'morpher/node'
require 'morpher/node_helpers'
require 'morpher/registry'
require 'morpher/printer'
require 'morpher/printer/mixin'
require 'morpher/evaluator'
require 'morpher/evaluator/nullary'
require 'morpher/evaluator/unary'
require 'morpher/evaluator/nary'
require 'morpher/evaluator/parameterized'
require 'morpher/evaluator/transformer'
require 'morpher/evaluator/transformer/block'
require 'morpher/evaluator/transformer/key'
require 'morpher/evaluator/transformer/anima'
require 'morpher/evaluator/transformer/guard'
require 'morpher/evaluator/transformer/attribute'
require 'morpher/evaluator/transformer/hash_transform'
require 'morpher/evaluator/predicate'
require 'morpher/evaluator/predicate/eql'
require 'morpher/evaluator/predicate/primitive'
require 'morpher/evaluator/predicate/negation'
require 'morpher/evaluator/predicate/tautology'
require 'morpher/evaluator/predicate/contradiction'
require 'morpher/evaluator/predicate/or'
require 'morpher/evaluation'
require 'morpher/evaluation'
require 'morpher/type_lookup'
require 'morpher/compiler'
require 'morpher/preprocessor'
