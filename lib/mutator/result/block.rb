class Mutator
  class Result 

    # Result of chained mutators
    class Block < Abstract::NAry

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
        body.inject(input) do |input, mutator|
          result = mutator.run(input)

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
