module Ducktrap
  class Node
    class Key
      # Ducktrap to dump value to a specific key
      class Add < self

        register :add_key

        # Return inverse ducktrap
        #
        # @return [Ducktrap]
        #
        # @api private
        #
        def inverse
          Delete.new(operand, key)
        end

        # Evaluator for add key node
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
          def process_operand_output
            input.merge(key => operand_output)
          end

        end
      end
    end
  end
end
