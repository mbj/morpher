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

      private

        # Process successful operand output
        #
        # @return [Object]
        #
        # @api private
        #
        def process_operand_output
          { key => operand_output }
        end
      end

    end
  end
end
