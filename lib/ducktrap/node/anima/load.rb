module Ducktrap
  class Node
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

        # Evaluator of anima load ducktrap
        class Evaluator < Anima::Evaluator

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

        end # Evaluator
      end # Load
    end
  end
end
