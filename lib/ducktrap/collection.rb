class Ducktrap
  # Ducktrap that applies operand over collection
  class Collection < self
    include Unary, Equalizer.new(:operand)

    register :collection

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
