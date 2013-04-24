module Ducktrap
  class Node
    # Ducktrap with noop inverse
    class Forward < self
      include Unary, Concord.new(:operand)

      register :forward

      # Return evaluator
      #
      # @param [Object] input
      #
      # @return [Evaluator]
      #
      # @api private
      #
      def inverse
        Noop.instance
      end

    private

      # Perform pretty dump
      #
      # @return [self]
      #
      # @api private
      #
      def dump(output)
        output.name(self)
        output.nest('inverse:', inverse)
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

      end

    end
  end
end
