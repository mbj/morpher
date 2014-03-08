module Morpher
  class Compiler
    # Compiler with evaluators as output
    class Evaluator < self

      # Return evaluator tree for node
      #
      # @param [Node] node
      #
      # @return [Evalautor]
      #   on success
      #
      # @raise [Compiler::Error]
      #   on error
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

    end # Evaluator
  end # Compiler
end # Morpher
