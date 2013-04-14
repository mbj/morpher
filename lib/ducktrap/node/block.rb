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

      # Return new instance
      #
      # @param [Array<Node>] nodes
      #
      # @return [Node]
      #
      # @api private
      #
      def self.new(nodes)
        if nodes.one?
          nodes.first
        else
          super
        end
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
            evaluator = ducktrap.run(input)

            unless evaluator.successful?
              return nested_error(evaluator)
            end

            evaluator.output
          end
        end
      end
    end
  end
end
