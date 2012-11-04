require 'abstract_class'
require 'equalizer'
require 'adamantium'
require 'addressable/uri'
require 'anima'

# Library namespace and abstract base class for ducktraps
class Ducktrap
  include AbstractClass, Adamantium::Flat

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

  # Return result class
  #
  # @return [Class:Result]
  #
  # @api private
  #
  def result_klass
    self.class::Result
  end

  def pretty_dump(output)
    output.puts(self.class.name)
  end

end

require 'ducktrap/error'

require 'ducktrap/builder'

require 'ducktrap/result'
require 'ducktrap/result/static'


require 'ducktrap/registry'

require 'ducktrap/nary'
require 'ducktrap/unary'
require 'ducktrap/nullary'
require 'ducktrap/uncategorized'

require 'ducktrap/member'

require 'ducktrap/block'
require 'ducktrap/params_hash'
require 'ducktrap/attributes_hash'
require 'ducktrap/anima'
