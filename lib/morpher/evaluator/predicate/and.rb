# encoding: UTF-8

module Morpher
  class Evaluator
    class Predicate
      # Evaluator for nary and predicates
      class And < self
        include Nary

        register :and

        # Call evaluator with input
        #
        # @param [Object] input
        #
        # @return [true]
        #   if all inner evaluators return true
        #
        # @return [false]
        #   otherwise
        #
        # @api private
        #
        def call(input)
          body.all? { |evaluator| evaluator.call(input) }
        end

        # Return evaluation for input
        #
        # @param [Object] input
        #
        # @return [Evaluation::Nary]
        #
        # @api private
        #
        def evaluation(input)
          evaluations = body.each_with_object([]) do |evaluator, aggregate|
            evaluation = evaluator.evaluation(input)
            aggregate << evaluation
            return evaluation_negative(input, aggregate) unless evaluation.output
          end

          evaluation_positive(input, evaluations)
        end

      end # Or
    end # Predicate
  end # Evaluator
end # Morpher
