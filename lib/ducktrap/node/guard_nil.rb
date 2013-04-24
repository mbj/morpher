module Ducktrap
  class Node
    # Transformation node to guard nil inputs as nil outputs
    class GuardNil < self
      include Unary, Equalizer.new(:operand)

      register :guard_nil

      # Return inverse transformation
      #
      # @return [Node]
      #
      # @api private
      #
      def inverse
        GuardNil.new(operand.inverse)
      end

      # Evaluator for guard nil node
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
          return if input.nil?
          operand_output
        end

      end
    end
  end
end
