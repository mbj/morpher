class Ducktrap
  class Key
    # Ducktrap to dump value to a specific key
    class Dump < self

      register :dump_key

      # Return inverse ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def inverse
        Fetch.new(operand.inverse, key)
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
            nested_error(result)
          end
          { key =>  result.output }
        end
      end

    end
  end
end
