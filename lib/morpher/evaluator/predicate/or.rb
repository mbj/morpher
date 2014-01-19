# encoding: UTF-8

module Morpher
  class Evaluator
    class Predicate
      # Evaluator for nary or predicates
      class Or < self
        include Nary

        register :or

        # Call evaluator with input
        #
        # @param [Object] input
        #
        # @return [true]
        #   if at least one inner evaluator returns true
        #
        # @return [false]
        #   otherwise
        #
        def call(input)
          body.any? { |evaluator| evaluator.call(input) }
        end

        # Return evaluation for input
        #
        # @param [Object] input
        #
        # @return [Evaluation::Nary]
        #
        #
        def evaluation(input)
          evaluations = body.each_with_object([]) do |evaluator, aggregate|
            evaluation = evaluator.evaluation(input)
            aggregate << evaluation
            return evaluation_positive(input, aggregate) if evaluation.output
          end

          evaluation_negative(input, evaluations)
        end

      end # Or
    end # Predicate
  end # Evaluator
end # Morpher
