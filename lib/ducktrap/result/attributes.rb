class Ducktrap
  class Result

    # Result ducktrap with attributes as output
    class Attributes < Abstract::NAry

      equalize

    private

      # Calcualte result
      #
      # @return [Hash]
      #   if successful
      #
      # @return [Undefined]
      #   otherwise
      #
      # @api private
      #
      def result
        results = body.map do |ducktrap| 
          ducktrap.run(input) 
        end

        return Undefined unless results.all?(&:successful?)

        results.each_with_object({}) do |result, hash|
          hash[result.name] = result.output
        end
      end

    end
  end
end
