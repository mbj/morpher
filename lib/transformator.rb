require 'abstract_class'
require 'equalizer'
require 'immutable'

# Abstract base class for transformator and library namespace
#
# The idea is to have transformators that do not fail silently or 
# raise abitrary exceptions on malformed input.
#
# All transformators respond to #result and #successful? With nesting
#
class Transformator
  include AbstractClass, Immutable, Equalizer.new(:input, :result, :errors)

  # Undefined result
  module Undefined; freeze; end

  # Register dsl name
  #
  # @param [Symbol] name
  #
  def self.register(name)
    Transformator::Builder.register(name, self)
  end

  # Run transformator for input
  #
  # @param [Object] input
  #
  # @return [Transformator]
  #
  def self.run(*arguments)
    new(*arguments)
  end

  # Build a transformator
  #
  # @return [Builder]
  #
  # @api private
  #
  def self.build(*arguments, &block)
    self::Builder.new(*arguments, &block)
  end

  # Test if load was successful
  #
  # @return [true]
  #   if loading was successful
  #
  # @return [false]
  #   otherwise
  #
  # @api private
  #
  def successful?
    result != Undefined
  end

  # Return loading errors
  #
  # @return [Enumerable<Error>]
  #
  # @api private
  #
  attr_reader :errors

  # Return input
  #
  # @return [Object]
  #
  # @api private
  #
  attr_reader :input

  # Return result
  #
  # @return [Object]
  #
  # @api private
  #
  def result
    load
  end
  memoize :result

private

  # Initialize object
  #
  # @param [Object] input
  #   the input to dload
  #
  # @return [undefined]
  #
  # @api private
  #
  def initialize(input)
    @input  = input
    @errors = []
    # Trigger load
    result
  end

  # Store error
  #
  # @param [Error]
  #
  # @return [undefined]
  #
  # @api private
  #
  def error(error)
    @errors << error
  end

  # Store exception as error
  #
  # @param [Class:Error] wrapper_class
  #   the error class to wrap into
  #
  # @param [Exception] exception
  #
  # @return [undefined]
  #
  def add_exception(wrapper_class, exception)
    error(wrapper_class.new(exception))
  end

  # Store errors
  #
  # @param [Enumerable<Error>] errors
  #
  # @return [undefined]
  #
  # @api private
  #
  def add_errors(errors)
    errors.each { |error| error(error) }
  end

  # Return input in loaded form
  #
  # @return [Object]
  #   if load is successful
  #
  # @return [Undefined]
  #   otherwise
  #  
  # @api private
  #
  abstract_method :load
  private :load
end

require 'transformator/error'
require 'transformator/builder'
require 'transformator/params'
require 'transformator/chain'
require 'transformator/string'
require 'transformator/primitive'
require 'transformator/primitive/string'
require 'transformator/attributes'
require 'transformator/attribute'
require 'transformator/attribute/params'
require 'transformator/fixnum'
require 'transformator/fixnum/string'
require 'transformator/params'
require 'transformator/string'
require 'transformator/string/non_empty'
require 'transformator/primitive'
