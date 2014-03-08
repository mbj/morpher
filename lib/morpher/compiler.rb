# encoding: UTF-8

module Morpher

  # Abstract compiler base class
  class Compiler
    include AbstractType, Concord.new(:registry)

    # Assert number of child nodes
    #
    # @param [Morpher::Node] nodes
    #
    # @return [self]
    #   if assertion is fullfilled
    #
    # @raise [NodeError]
    #   otherwise
    #
    # @api private
    #
    def self.assert_child_nodes(node, expected_amount)
      actual_amount = node.children.length
      unless actual_amount == expected_amount
        puts node.type.inspect
        raise Error::NodeChildren.new(node, expected_amount)
      end
    end

    # Call compiler
    #
    # @param [Node] node
    #
    # @return [Object]
    #
    abstract_method :call

  end # Compiler
end # Morpher
