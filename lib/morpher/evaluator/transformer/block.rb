module Morpher

  class Evaluator
    class Transformer

      # Evaluator to perform n transformations in a row
      class Block < self
        include Nary

        register :block

        # Call transformer
        #
        # @param [Object] input
        #
        # @return [Object]
        #
        # @api private
        #
        def call(input)
          body.inject(input) do |state, evaluator|
            evaluator.call(state)
          end
        end

        # Return inverse evaluator
        #
        # @return [Evaluator]
        #
        # @api private
        #
        def inverse
          self.class.new(body.reverse.map(&:inverse))
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
          evaluations = []

          output = body.reduce(input) do |state, evaluator|
            evaluation = evaluator.evaluation(state)
            evaluations << evaluation
            evaluation.output
          end

          Evaluation::Nary.new(
            evaluator:   self,
            input:       input,
            output:      output,
            evaluations: evaluations
          )
        end

      end # Block
    end # Transformer
  end # Evaluato
end # Morpher
