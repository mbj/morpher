require 'abstract_class'
require 'equalizer'
require 'immutable'
require 'rack'
require 'anima'

# Library namespace and abstract base class for ducktraps
class Ducktrap
  include AbstractClass, Immutable

  # Undefined result
  module Undefined; freeze; end

  # Run ducktrap on input
  #
  # @param [Object] input
  #
  # @return [Resulft]
  #
  # @api private
  #
  abstract_method :run

  # Register dsl name
  #
  # @param [Symbol] name
  # @param [Class:Ducktrap] ducktrap
  #
  # @return [self]
  #
  def self.register(name)
    DSL.register(name, self)
  end
  private_class_method :register

  # Create new ducktrap
  #
  # @return [Ducktrap]
  #
  # @api private
  #
  def self.build(*args, &block)
    NAry::Block.new(*args, &block)
  end

private

  # Initialize object
  #
  # @return [undefined]
  #
  # @api private
  #
  def initialize(&block)
    instance_eval(&block) if block
  end
end

require 'ducktrap/result'
require 'ducktrap/result/abstract'
require 'ducktrap/result/fixnum'
require 'ducktrap/result/fixnum/string'
require 'ducktrap/result/params'
require 'ducktrap/result/params/url_encoded'
require 'ducktrap/result/params/rack'
require 'ducktrap/result/params/rack/multipart_form_data'
require 'ducktrap/result/block'
require 'ducktrap/result/attribute'
require 'ducktrap/result/attribute/params'
require 'ducktrap/result/attributes'
require 'ducktrap/result/primitive'
require 'ducktrap/result/anima'
require 'ducktrap/result/nary'

require 'ducktrap/abstract'
require 'ducktrap/registry'
require 'ducktrap/version'
require 'ducktrap/primitive/string'
require 'ducktrap/anima'
require 'ducktrap/attributes'
require 'ducktrap/params'
require 'ducktrap/nary'
require 'ducktrap/fixnum'
require 'ducktrap/registry'
require 'ducktrap/attribute'
require 'ducktrap/primitive'
require 'ducktrap/nil'
