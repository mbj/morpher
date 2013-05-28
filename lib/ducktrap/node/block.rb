module Ducktrap
  class Node
    # Ducktrap that returns last evaluator output of a chain and stops on first failure.
    # Acts like AND with multiple inputs.
    class Block < self
      include NAry

      # Return inverse ducktrap
      #
      # @return [Node]
      #
      # @api private
      #
      def inverse
        self.class.new(inverse_body)
      end

      # Evaluator of chained ducktraps
      class Evaluator < NAry::Evaluator

      private

        # Calculate evaluator
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
          body.inject(input) do |input, ducktrap|
            evaluator = ducktrap.call(input)
            return nested_error(evaluator) unless evaluator.successful?
            evaluator.output
          end
        end

      end # Evaluator
    end # Block
  end # Node
end # Ducktrap
