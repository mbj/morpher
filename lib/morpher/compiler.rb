module Morpher

  # The AST to evaluator tree compiler
  class Compiler
    include Concord.new(:registry)

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
