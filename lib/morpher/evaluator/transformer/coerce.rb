# encoding: UTF-8

module Morpher
  class Evaluator
    class Transformer
      # Abstract namespace class for coercing transformers
      class Coerce < self
        include AbstractType, Nullary::Parameterized, Transitive

        # Evaluator for parsing an integer
        class ParseInt < self

          register :parse_int

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
          rescue ArgumentError, TypeError
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
          rescue ArgumentError, TypeError
            evaluation_error(input)
          end

          # Return inverse evaluator
          #
          # @return [Evaluator]
          #
          # @api private
          #
          def inverse
            IntToString.new(param)
          end

          private

          # Invoke coercion
          #
          # @return [Integer]
          #
          # @raise [ArgumentError, TypeError]
          #   if coercion does not succeed
          #
          # @api private
          #
          def invoke(input)
            Integer(input, param)
          end

        end # ParseInt

        # Evaluator for dumping fixnums to strings
        class IntToString < self

          register :int_to_string

          # Call evaluator
          #
          # @param [Object] input
          #
          # @return [Hash<Symbol, Object>]
          #
          # @api private
          #
          def call(input)
            input.to_s(param)
          end

          # Return inverse evaluator
          #
          # @return [Evaluator]
          #
          # @api private
          #
          def inverse
            ParseInt.new(param)
          end

        end # IntToString

      end # Fixnum
    end # Transformer
  end # Evaluator
end # Morpher
