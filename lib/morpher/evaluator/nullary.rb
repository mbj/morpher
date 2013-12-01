module Morpher
  class Evaluator
    # Mixin to define nullary evaluators
    module Nullary

      # Return evaluation for input
      #
      # @param [Object] input
      #
      # @return [Evaluation]
      #
      # @api private
      #
      def evaluation(input)
        output = call(input)
        Evaluation.new(
          :evaluator => self,
          :input     => input,
          :output    => output
        )
      end

    end # Nullary
  end # Evaluator
end # Morpher
