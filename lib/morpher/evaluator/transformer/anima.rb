module Morpher
  class Evaluator
    class Transformer
      # Abstract namespace class for anima transformer evaluators
      class Anima < self
        include Nullary, Parameterized, Transitive

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
            input.to_h
          end

          # Return inverse evaluator
          #
          # @return [Evaluator]
          #
          # @api private
          #
          def inverse
            Load.new(param)
          end

        end # Dump

        # Evaluator for loading anima state
        class Load < self

          register :anima_load

          # Call evaluator
          #
          # @param [Object] input
          #
          # @return [Object]
          #   an instance of an anima infected class
          #
          # @api private
          #
          def call(input)
            param.new(input)
          rescue ::Anima::Error
            raise_transform_error(input)
          end

          # Return evaluation
          #
          # @param [Object] input
          #
          # @return [Evaluation]
          #
          # @api private
          #
          def evaluation(input)
            Evaluation.success(
              evaluator: self,
              input:     input,
              output:    param.new(input),
            )
          rescue ::Anima::Error
            Evaluation.error(
              evaluator: self,
              input:     input,
            )
          end

          # Return inverse evaluator
          #
          # @return [Evaluator]
          #
          # @api private
          #
          def inverse
            Dump.new(param)
          end

        end # Load
      end # Anima
    end # Transformer
  end # Evaluator
end # Morpher
