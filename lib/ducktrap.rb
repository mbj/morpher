require 'backports'
require 'abstract_type'
require 'equalizer'
require 'composition'
require 'adamantium'
require 'addressable/uri'
require 'anima'

# ::Ducktrap needs this
require 'ducktrap/pretty_dump'

# Library namespace and abstract base class for ducktraps
class Ducktrap
  include AbstractType, PrettyDump, Adamantium::Flat

  class InvalidInputError < RuntimeError
    include Adamantium::Flat, Composition.new(:error)

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
    unless result.successful?
      raise InvalidInputError.new(result)
    end
    result.output
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

  # Perform pretty dump of ducktrap
  #
  # @return [self]
  #
  # @api private
  #
  def pretty_dump(output=Formatter.new)
    dump(output)
    self
  end

  abstract_method :dump

  # Build ducktrap
  #
  # @return [Ducktrap]
  #
  # @api private
  #
  def self.build(&block)
    Block.build(&block)
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
require 'ducktrap/nary'
require 'ducktrap/unary'
require 'ducktrap/nullary'
require 'ducktrap/uncategorized'
require 'ducktrap/noop'
require 'ducktrap/member'
require 'ducktrap/named_value'
require 'ducktrap/block'
require 'ducktrap/collection'
require 'ducktrap/params_hash'
require 'ducktrap/params_hash/string'
require 'ducktrap/params_hash/string/json'
require 'ducktrap/params_hash/string/url_encoded'
require 'ducktrap/attributes_hash'
require 'ducktrap/attribute'
require 'ducktrap/anima'
require 'ducktrap/primitive'
require 'ducktrap/fixnum'
require 'ducktrap/string'
require 'ducktrap/static'
require 'ducktrap/polymorphic'
require 'ducktrap/external'
