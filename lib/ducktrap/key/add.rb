class Ducktrap
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

      class Result < Key::Result

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
          result = processed_input
          unless result.successful?
            return nested_error(result)
          end
          input.merge(key => result.output)
        end

      end
    end
  end
end
