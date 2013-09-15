require 'abstract_type'
require 'equalizer'
require 'concord'
require 'adamantium'
require 'addressable/uri'
require 'anima'

# Library namespace
module Ducktrap

  # Error raised on failed transformation
  class FailedTransformationError < RuntimeError
    include Adamantium::Flat, Concord::Public.new(:evaluator)

    # Return error message
    #
    # @return [String]
    #
    # @api private
    #
    def message
      evaluator.pretty_inspect
    end
    memoize :message

  end

  # Build ducktrap
  #
  # @return [Node]
  #
  # @api private
  #
  def self.build(&block)
    Node::Block.build(&block)
  end
end

require 'ducktrap/pretty_dump'
require 'ducktrap/formatter'
require 'ducktrap/error'
require 'ducktrap/evaluator'
require 'ducktrap/evaluator/static'
require 'ducktrap/evaluator/invalid'
require 'ducktrap/builder'
require 'ducktrap/registry'
require 'ducktrap/nullary'
require 'ducktrap/unary'
require 'ducktrap/singleton'
require 'ducktrap/nary'
require 'ducktrap/mapper'
require 'ducktrap/node'
require 'ducktrap/node/key'
require 'ducktrap/node/key/fetch'
require 'ducktrap/node/key/dump'
require 'ducktrap/node/key/delete'
require 'ducktrap/node/key/add'
require 'ducktrap/node/guard_nil'
require 'ducktrap/node/noop'
require 'ducktrap/node/invalid'
require 'ducktrap/node/block'
require 'ducktrap/node/map'
require 'ducktrap/node/disjunction'
require 'ducktrap/node/anima'
require 'ducktrap/node/anima/load'
require 'ducktrap/node/anima/dump'
require 'ducktrap/node/primitive'
require 'ducktrap/node/inverse'
require 'ducktrap/node/forward'
require 'ducktrap/node/static'
require 'ducktrap/node/custom'
require 'ducktrap/node/hash'
require 'ducktrap/node/hash/transform'
