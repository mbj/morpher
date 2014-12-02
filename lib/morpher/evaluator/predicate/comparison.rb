# encoding: UTF-8

module Morpher
  class Evaluator
    class Predicate

      # Base class for comparison predicates
      class Comparison < self
        include Binary

        # Call evaluator
        #
        # @param [Object] input
        #
        # @return [true]
        #   if input is semantically equivalent to expectation
        #
        # @return [false]
        #   otherwise
        #
        # @api private
        #
        def call(input)
          apply(left.call(input), right.call(input))
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
          left_evaluation  = left.evaluation(input)
          right_evaluation = right.evaluation(input)

          if [left_evaluation, right_evaluation].all?(&:success?)
            Evaluation::Binary.success(
              evaluator: self,
              input: input,
              output: apply(left_evaluation.output, right_evaluation.output),
              left_evaluation: left_evaluation,
              right_evaluation: right_evaluation
            )
          else
            Evaluation::Binary.error(
              evaluator: self,
              input: input,
              left_evaluation: left_evaluation,
              right_evaluation: right_evaluation
            )
          end
        end

        private

        def apply(left, right)
          left.public_send(self.class::OPERATOR, right)
        end
      end # Comparison

      # Binary "#eql?" evaluator
      class EQL < Comparison
        register :eql

        OPERATOR = :eql?
      end # EQL

      # Binary "greater than" evaluator
      class GT < Comparison
        register :gt

        OPERATOR = :>
      end # GT

      # Binary "greater than or equal" evaluator
      class GTE < Comparison
        register :gte

        OPERATOR = :>=
      end # GTE

      # Binary "greater than" evaluator
      class LT < Comparison
        register :lt

        OPERATOR = :<
      end # LT

      # Binary "greater than or equal" evaluator
      class LTE < Comparison
        register :lte

        OPERATOR = :<=
      end # LTE
    end # Predicate
  end # Evaluator
end # Morpher
