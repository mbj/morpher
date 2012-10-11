class Ducktrap
  class Result 

    # Result of chained ducktraps
    class Block < Abstract::NAry

      equalize

    private

      # Calculate result
      #
      # @return [Object]
      #   if successful
      #
      # @return [Undefined]
      #   otherwise
      #
      # @api private
      #
      def result
        body.inject(input) do |input, ducktrap|
          result = ducktrap.run(input)

          if result.successful?
            result.output
          else
            return Undefined
          end
        end
      end

    end
  end
end
