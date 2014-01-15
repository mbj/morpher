module Morpher
  class Evaluator
    class Transformer

      # Transformer that allows to guard transformation process with a predicate on input
      class Guard < self
        include Unary, Transitive

        register :guard

        # Call evaluator
        #
        # @parma [Object] input
        #
        # @return [Object]
        #   if input evaluates true under predicate
        #
        # @raise [TransformError]
        #   otherwise
        #
        # @api private
        #
        def call(input)
          if operand.call(input)
            input
          else
            raise TransformError.new(self, input)
          end
        end

        # Return evaluation
        #
        # @param [Object] input
        #
        # @return [Evaluation::Guard]
        #
        # @api private
        #
        def evaluation(input)
          operand_evaluation = operand.evaluation(input)
          if operand_evaluation.output
            Evaluation::Unary.success(
              input:              input,
              output:             input,
              operand_evaluation: operand_evaluation,
              evaluator:          self
            )
          else
            Evaluation::Unary.error(
              input:              input,
              operand_evaluation: operand_evaluation,
              evaluator:          self
            )
          end
        end

        # Return inverse evaluator
        #
        # @return [self]
        #
        # @api private
        #
        def inverse
          self
        end

      end # Guard
    end # Transformer
  end # Evaluator
end # Morpher
