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
  def self.compile(node)
    node = Preprocessor.new(Preprocessor::Emitter::REGISTRY).call(node)
    Compiler.new(Evaluator::REGISTRY).call(node)
  end

  # Return evaluate block to produce an AST node
  #
  # @return [Morpher::Node]
  #
  # @api private
  #
  def self.sexp(&block)
    NodeHelpers.module_eval(&block)
  end

end # Morpher

require 'morpher/node'
require 'morpher/node_helpers'
require 'morpher/registry'
require 'morpher/printer'
require 'morpher/printer/mixin'
require 'morpher/evaluator'
require 'morpher/evaluator/nullary'
require 'morpher/evaluator/nullary/parameterized'
require 'morpher/evaluator/unary'
require 'morpher/evaluator/binary'
require 'morpher/evaluator/nary'
require 'morpher/evaluator/transformer'
require 'morpher/evaluator/transformer/block'
require 'morpher/evaluator/transformer/key'
require 'morpher/evaluator/transformer/anima'
require 'morpher/evaluator/transformer/guard'
require 'morpher/evaluator/transformer/attribute'
require 'morpher/evaluator/transformer/hash_transform'
require 'morpher/evaluator/transformer/map'
require 'morpher/evaluator/transformer/static'
require 'morpher/evaluator/transformer/input'
require 'morpher/evaluator/transformer/merge'
require 'morpher/evaluator/transformer/coerce'
require 'morpher/evaluator/predicate'
require 'morpher/evaluator/predicate/eql'
require 'morpher/evaluator/predicate/primitive'
require 'morpher/evaluator/predicate/negation'
require 'morpher/evaluator/predicate/tautology'
require 'morpher/evaluator/predicate/contradiction'
require 'morpher/evaluator/predicate/boolean'
require 'morpher/evaluation'
require 'morpher/evaluation'
require 'morpher/type_lookup'
require 'morpher/compiler'
require 'morpher/preprocessor'
require 'morpher/preprocessor/emitter'
