# encoding: UTF-8

module Morpher

  # The AST to evaluator tree compiler
  class Compiler
    include Concord.new(:registry)

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

    # Return evaluator tree for node
    #
    # @param [Node] node
    #
    # @return [Evalautor]
    #
    # @api private
    #
    def call(node)
      lookup(node).build(self, node)
    end

  private

    # Lookup evaluator builder
    #
    # @return [#build]
    #   if found
    #
    # @raise UnknownNodeTypeError
    #   otherwise
    #
    # @api private
    #
    def lookup(node)
      type = node.type
      registry.fetch(type) do
        raise Error::UnknownNode, type
      end
    end

  end # Compiler
end # Morpher
