# encoding: UTF-8

module Morpher

  # The AST to evaluator tree compiler
  class Compiler
    include Concord.new(:registry)

    # Error raised when node children have incorrect amount
    class NodeChildrenError < RuntimeError
      include Concord.new(:node, :expected_amount)

      # Return exception message
      #
      # @return [String]
      #
      # @api private
      #
      def message
        "Expected #{expected_amount} #{_children} for #{type}, got #{actual_amount}: #{children}"
      end

      private

      def type
        node.type.inspect
      end

      def actual_amount
        children.length
      end

      def children
        node.children
      end

      def _children
        expected_amount == 1 ? 'child' : 'children'
      end
    end

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
        raise NodeChildrenError.new(node, expected_amount)
      end
    end

    # Error raised on compiling unknown nodes
    class UnknownNodeError < RuntimeError
      include Concord.new(:type)

      # Return exception error message
      #
      # @return [String]
      #
      # @api private
      #
      def message
        "Node type: #{type.inspect} is unknown"
      end

    end # UnknownNodeError

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
        raise UnknownNodeError, type
      end
    end

  end # Compiler
end # Morpher
