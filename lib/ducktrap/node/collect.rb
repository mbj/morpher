module Ducktrap
  class Node
    # Ducktrap that collects evaluators with executing inner ducktraps with the same input
    class Collect < self
      include NAry

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
          body.each_with_object({}) do |ducktrap, hash|
            evaluator = ducktrap.run(input)

            unless evaluator.successful?
              return nested_error(evaluator)
            end

            output = evaluator.output

            hash.merge!(evaluator.output)
          end
        end
      end
    end
  end
end
