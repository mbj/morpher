class Ducktrap
  class Anima
    # Load attributes hash
    class Load < self
      register :anima_load

      # Return inverse ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def inverse
        Dump.new(operand.inverse, model)
      end

      # Result of anima load ducktrap
      class Result < Anima::Result

      private

        # Process input
        #
        # @return [Object]
        #
        # @api private
        #
        def process_operand_output
          model.new(operand_output)
        rescue ::Anima::Error 
          error
        end

      end # Result
    end # Load
  end
end
