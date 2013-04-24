module Ducktrap
  class Node
    class Key
      # Ducktrap to dump value to a specific key
      class Delete < self

        register :delete_key

        # Return inverse ducktrap
        #
        # @return [Ducktrap]
        #
        # @api private
        #
        def inverse
          Add.new(operand, key)
        end

        # Evaluator for delete key node
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
            dup = input.dup
            dup.delete(key)
            dup
          end
        end

      end
    end
  end
end
