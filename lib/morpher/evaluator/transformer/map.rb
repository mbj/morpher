# encoding: UTF-8

module Morpher
  class Evaluator
    class Transformer

      # Transformer over each element in an enumerable
      class Map < self
        include Unary

        register :map

        # Test if evaluator is transitive
        #
        # @return [true]
        #   if evaluator is transitive
        #
        # @return [false]
        #   otherwise
        #
        # @api private
        #
        def transitive?
          operand.transitive?
        end

        # Call evaluator
        #
        # @parma [Enumerable#map] input
        #
        # @return [Enumerable]
        #   if input evaluates true under predicate
        #
        # @raise [TransformError]
        #   otherwise
        #
        # @api private
        #
        def call(input)
          input.map do |item|
            operand.call(item)
          end
        end

        # Return evaluation
        #
        # @param [Enumerable#map] input
        #
        # @return [Evaluation::Guard]
        #
        # @api private
        #
        def evaluation(input)
          evaluations = input.each_with_object([]) do |item, aggregate|
            evaluation = operand.evaluation(item)
            aggregate << evaluation
            return evaluation_error(item, aggregate) unless evaluation.success?
          end

          Evaluation::Nary.success(
            evaluator:   self,
            input:       input,
            output:      evaluations.map(&:output),
            evaluations: evaluations
          )
        end

        # Return inverse evaluator
        #
        # @return [Evaluator::Transformer]
        #
        # @api private
        #
        def inverse
          self.class.new(operand.inverse)
        end

      end # Guard
    end # Transformer
  end # Evaluator
end # Morpher
