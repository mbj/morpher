# encoding: UTF-8

module Morpher

  # Morpher specific AST node
  class Node < AST::Node

    # Initialize node
    #
    # AST::Node from whitequark/ast provides dynamic node properties. We dont use them so
    # this intializer strips away this part of the public interface.
    #
    # @param [Symbol] type
    # @param [Array<Node>] children
    #
    # @reutrn [undefined]
    #
    # @api private
    #
    def initialize(_type, _children)
      super
    end

  end # Node
end # Morpher
