# encoding: utf-8

module Morpher
  class Evaluator
    class Transformer

      # Transformer to give a name to a subtree
      class Name < self
        include Intransitive, Unary::Parameterized

        register :name

        # Call evaluator for input
        #
        # @param [Object] input
        #
        # @return [Object] input
        #
        # @api private
        #
        def call(input)
          operand.call(input)
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
          if (evaluation = operand.evaluation(input)).success?
            evaluation_success(input, evaluation, evaluation.output)
          else
            evaluation_error(input, evaluation)
          end
        end
      end # Name
    end # Transformer
  end # Evaluator
end # Morpher
