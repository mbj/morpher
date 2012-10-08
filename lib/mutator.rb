require 'abstract_class'
require 'equalizer'
require 'immutable'
require 'rack'
require 'anima'

# Library namespace and abstract base class for mutators
class Mutator
  include AbstractClass, Immutable

  # Undefined result
  module Undefined; freeze; end

  # Run mutator on input
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
  # @param [Class:Mutator] mutator
  #
  # @return [self]
  #
  def self.register(name)
    DSL.register(name, self)
  end
  private_class_method :register

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

require 'mutator/result'
require 'mutator/result/abstract'
require 'mutator/result/fixnum'
require 'mutator/result/fixnum/string'
require 'mutator/result/params'
require 'mutator/result/params/url_encoded'
require 'mutator/result/params/rack'
require 'mutator/result/params/rack/multipart_form_data'
require 'mutator/result/block'
require 'mutator/result/attribute'
require 'mutator/result/attribute/params'
require 'mutator/result/attributes'
require 'mutator/result/primitive'
require 'mutator/result/anima'
require 'mutator/result/whitelist'

require 'mutator/abstract'
require 'mutator/registry'
require 'mutator/block'
require 'mutator/version'
require 'mutator/primitive/string'
require 'mutator/anima'
require 'mutator/attributes'
require 'mutator/params'
require 'mutator/whitelist'
require 'mutator/fixnum'
require 'mutator/registry'
require 'mutator/attribute'
require 'mutator/primitive'
