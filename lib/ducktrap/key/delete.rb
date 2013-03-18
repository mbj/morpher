class Ducktrap
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
          dup = input.dup
          dup.delete(key)
          dup
        end
      end

    end
  end
end
