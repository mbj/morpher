class Ducktrap
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

      # Result for fetch key ducktrap
      class Result < Key::Result

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
            return nested_error(self)
          end
          result = process_operand(value)
          unless result.successful?
            return nested_error(result)
          end
          result.output
        end

      end
    end
  end
end
