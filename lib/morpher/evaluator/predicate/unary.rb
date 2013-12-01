module Morpher
  class Evaluator
    class Predicate
      # Abstract namespace class for unary predicates
      #
      # TODO: Remove and use as a mixin?
      # TODO: Is this node type needed?
      #
      #   s(:unary_negate, s(:eql, "foo"))
      #
      #   is equivalent to:
      #
      #   s(:block,
      #     s(:eql, "foo"),
      #     s(:nullary_negate
      #   )
      #
      class Unary < self
        include Concord.new(:operand)

      private

        # Return evaluation for input
        #
        # @param [Object] input
        #
        # @return [Evalation::Unary]
        #
        # @api private
        #
        def build_evaluation(input, operand_output, output)
          Evaluation::Unary.new(
            evaluator:      self,
            input:          input,
            operand_output: operand_output,
            output:         output
          )
        end

        # Unary negation
        class Negation < self

          # Return evaluation for input
          #
          # @param [Object] input
          #
          # @return [Evaluation]
          #
          # @api private
          #
          def evaluation(input)
            operand_output = operand.call(input)
            build_evaluation(input, operand_output, !operand_output)
          end

          # Call evaluator
          #
          # @param [Object] input
          #
          # @return [true]
          #   if input NOT evaluated to true under operand
          #
          # @return [false]
          #   otherwise
          #
          # @api private
          #
          def call(input)
            !operand.call(input)
          end

          # Return inverse evaluator
          #
          # @return [Evaluator]
          #
          # @api private
          #
          def inverse
            operand
          end

        end # Negation
      end # Unary
    end # Predicate
  end # Evaluator
 end # Morpher
