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

      # Result for collection ducktrap
      class Result < Unary::Result

      private

        # Calculate result
        #
        # @return [Object]
        #
        # @api private
        #
        def process
          input.map do |element|
            result = operand.run(element)
            unless result.successful?
              return nested_error(result)
            end
            result.output
          end
        end
      end
    end
  end
end
