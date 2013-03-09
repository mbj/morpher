require 'backports'
require 'abstract_type'
require 'equalizer'
require 'concord'
require 'adamantium'
require 'addressable/uri'
require 'anima'

# ::Ducktrap needs this
require 'ducktrap/pretty_dump'

# Library namespace and abstract base class for ducktraps
class Ducktrap
  include AbstractType, PrettyDump, Adamantium::Flat

  class InvalidInputError < RuntimeError
    include Adamantium::Flat, Concord.new(:error)

    # Return error message
    #
    # @return [String]
    #
    # @api private
    #
    def message
      io = StringIO.new
      formatter = Formatter.new(io)
      error.pretty_dump(formatter)
      io.rewind
      io.read
    end
    memoize :message

  end

  # Return inversed ducktrap
  #
  # @param [Object] input
  #
  # @return [Result]
  #
  # @api private
  #
  abstract_method :inverse

  # Run ducktrap on input
  #
  # @param [Object] input
  #
  # @return [Result]
  #
  # @api private
  #
  abstract_method :run

  # Process input and raise exception on error
  #
  # @param [Object] input
  #
  # @return [Object]
  #   if successful
  #
  # @raise [RuntimeError]
  #   otherwise
  #
  # @api private
  #
  def execute(input)
    result = run(input)
    output = result.output
    unless result.successful?
      raise InvalidInputError.new(output)
    end
    output
  end

  # Register dsl name
  #
  # @param [Symbol] name
  #
  # @return [self]
  #
  # @api private
  #
  def self.register(name)
    DSL.register(name, self)
  end
  private_class_method :register

  # Return result class
  #
  # @return [Class:Result]
  #
  # @api private
  #
  def result_klass
    self.class::Result
  end

  # Build ducktrap
  #
  # @return [Ducktrap]
  #
  # @api private
  #
  def self.build(&block)
    self::Block.build(&block)
  end

private

  # Dump object
  #
  # @param [Formatter] output
  #
  # @return [undefined]
  #
  # @api private
  #
  def dump(output)
    output.name(self)
  end
end

require 'ducktrap/formatter'
require 'ducktrap/error'
require 'ducktrap/inverse'
require 'ducktrap/result'
require 'ducktrap/result/static'
require 'ducktrap/result/invalid'
require 'ducktrap/builder'
require 'ducktrap/registry'
require 'ducktrap/nullary'
require 'ducktrap/unary'
require 'ducktrap/nary'
require 'ducktrap/key'
require 'ducktrap/key/fetch'
require 'ducktrap/key/dump'
require 'ducktrap/singleton'
require 'ducktrap/noop'
require 'ducktrap/block'
require 'ducktrap/collect'
require 'ducktrap/collection'
require 'ducktrap/anima'
require 'ducktrap/anima/load'
require 'ducktrap/anima/dump'
require 'ducktrap/primitive'
require 'ducktrap/fixnum'
require 'ducktrap/string'
require 'ducktrap/static'
require 'ducktrap/polymorphic'
require 'ducktrap/external'
