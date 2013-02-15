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
          process_operand(value).output
        end

      end
    end
  end
end
