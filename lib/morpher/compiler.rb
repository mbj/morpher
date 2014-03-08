# encoding: UTF-8

module Morpher

  # Abstract compiler base class
  class Compiler
    include AbstractType

    # Call compiler
    #
    # @param [Node] node
    #
    # @return [Object]
    #
    abstract_method :call

  end # Compiler
end # Morpher
