module Ducktrap
  class Node
    class Anima

      # Dumper for anima
      class Dump < self
        register :anima_dump

        # Return inverse ducktrap
        #
        # @return [Ducktrap]
        #
        # @api private
        #
        def inverse
          Load.new(operand.inverse, model)
        end

        class Evaluator < Anima::Evaluator

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
            evaluator = process_operand(attribute_hash)
            unless evaluator.successful?
              return nested_error(evaluator)
            end
            evaluator.output
          end

          # Return attribute hash
          #
          # @return [Hash]
          #
          # @api private
          #
          def attribute_hash
            model.attributes_hash(input)
          end

        end
      end 
    end
  end
end
