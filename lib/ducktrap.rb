require 'abstract_class'
require 'equalizer'
require 'adamantium'
require 'addressable/uri'
require 'anima'

# Library namespace and abstract base class for ducktraps
class Ducktrap
  include AbstractClass, Adamantium::Flat

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

  # Return result class
  #
  # @return [Class:Result]
  #
  # @api private
  #
  def result_klass
    self.class::Result
  end

  def pretty_dump(output=Formatter.new)
    output.puts(self.class.name)
  end
end

require 'ducktrap/error'

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
require 'ducktrap/attributes_hash'
require 'ducktrap/attribute'
require 'ducktrap/anima'
require 'ducktrap/primitive'
require 'ducktrap/fixnum'
require 'ducktrap/string'
require 'ducktrap/static'
require 'ducktrap/polymorphic'
require 'ducktrap/external'
