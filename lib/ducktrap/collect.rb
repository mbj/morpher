class Ducktrap
  # Ducktrap that collects results with executing inner ducktraps with the same input
  class Collect < self
    include Nary

    register :collect_hash

    # Return inverse ducktrap
    #
    # @return [Ducktrap]
    #
    # @api private
    #
    def inverse
      Collect.new(body.map(&:inverse))
    end

    # Result of chained ducktraps
    class Result < Nary::Result

    private

      # Calculate result
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
        body.each_with_object({}) do |ducktrap, hash|
          result = ducktrap.run(input)

          unless result.successful?
            return nested_error(result)
          end

          output = result.output

          hash.merge!(result.output)
        end
      end
    end
  end
end
