# encoding: UTF-8

module Morpher
  class Evaluator
    class Transformer
      # Abstract namespace class for anima transformer evaluators
      class Anima < self
        include AbstractType, Nullary::Parameterized, Transitive

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
            invoke(input)
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
            evaluation_success(input, invoke(input))
          rescue ::Anima::Error
            evaluation_error(input)
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

        private

          # Invoke the transformation
          #
          # @return [Object]
          #
          # @api private
          #
          def invoke(input)
            param.new(input)
          end

        end # Load
      end # Anima
    end # Transformer
  end # Evaluator
end # Morpher
