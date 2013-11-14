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
          Load.new(model)
        end

        # Evaluator for anima dump nodes
        class Evaluator < Anima::Evaluator

        private

          # Process input
          #
          # @return [Hash]
          #   if successful
          #
          # @api private
          #
          def process
            input.to_h
          end

        end
      end
    end
  end
end
