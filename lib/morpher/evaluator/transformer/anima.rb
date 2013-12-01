module Morpher
  class Evaluator
    class Transformer
      # Abstract namespace class for anima transformer evaluators
      class Anima < self
        include Nullary, Parameterized

        # Evaluator for dumping anima state
        class Dump < self

          register :anima_dump

          # Call evaluator
          #
          # @param [Object] input
          #
          # @return [Hash<Symbol, Object>]
          #
          # @api private
          #
          def call(input)
            param.attributes_hash(input)
          end

          # Return inverse evaluator
          #
          # @return [Evaluator]
          #
          # @api private
          #
          def inverse
            Anima::Load.new(param)
          end

        end # Dump

        # Evaluator for loading anima state
        class Load < self

          register :anima_load

          # Call evaluator
          #
          # @param [Object] input
          #
          # @return [Anima]
          #
          # @api private
          #
          def call(input)
            param.new(input)
          end

          # Return inverse evaluator
          #
          # @return [Evaluator]
          #
          # @api private
          #
          def inverse
            Anima::Dump.new(param)
          end

        end # Load
      end # Anima
    end # Transformer
  end # Evaluator
end # Morpher
