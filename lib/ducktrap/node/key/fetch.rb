module Ducktrap
  class Node
    class Key
      # Ducktrap to fetch and transform a specific key
      class Fetch < self

        register :fetch_key

        # Return inverse ducktrap
        #
        # @return [Ducktrap]
        #
        # @api private
        #
        def inverse
          Dump.new(operand.inverse, key)
        end

        # Evaluator for fetch key ducktrap
        class Evaluator < Key::Evaluator

        private

          # Process input
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
            value = input.fetch(context.key) do
              return error
            end
            evaluator = process_operand(value)
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
