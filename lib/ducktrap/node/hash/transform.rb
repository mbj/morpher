module Ducktrap
  class Node
    class Hash
      # Ducktrap that expects outputs to be hashes and merges them together 
      #
      # TODO: Find better primitive!
      #
      class Transform < self
        include NAry

        register :hash_transform

        # Return inverse transformation
        #
        # @return [Node]
        #
        # @api privateo
        #
        def inverse
          self.class.new(body.map(&:inverse))
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
              evaluator = ducktrap.call(input)

              unless evaluator.successful?
                return nested_error(evaluator)
              end

              hash.merge!(evaluator.output)
            end
          end
        end
      end
    end
  end
end
