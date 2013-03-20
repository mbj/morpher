module Ducktrap
  class Node
    # Ducktrap that performs map operation
    class Map < self
      include Unary

      register :map

      # Return inverse transformator
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def inverse
        self.class.new(operand.inverse)
      end

      # Evaluator for collection ducktrap
      class Evaluator < Unary::Evaluator

      private

        # Calculate evaluator
        #
        # @return [Object]
        #
        # @api private
        #
        def process
          input.map do |element|
            evaluator = operand.run(element)
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
