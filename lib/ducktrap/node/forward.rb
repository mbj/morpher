module Ducktrap
  class Node
    # Ducktrap with noop inverse
    class Forward < self
      include Unary, Concord::Public.new(:operand)

      register :forward

      # Return inverse node
      #
      # @return [Inverse]
      #
      # @api private
      #
      def inverse
        Inverse.new(operand)
      end

    private

      # Perform pretty dump
      #
      # @return [undefined]
      #
      # @api private
      #
      def dump(output)
        output.name(self)
        output.nest(:operand, operand)
      end

      # Evaluator for forward nodes
      class Evaluator < Unary::Evaluator

      private

        # Return output
        #
        # @return [Object]
        #   if successful
        #
        # @return [Error]
        #   otherwise
        #
        # @api private
        #
        def process
          operand_output
        end

      end # Evaluator

    end # Forward
  end # Node
end # Ducktrap
