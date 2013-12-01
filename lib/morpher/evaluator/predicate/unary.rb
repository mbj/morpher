module Morpher
  class Evaluator
    class Predicate
      # Abstract namespace class for unary predicates
      #
      # TODO: Remove and use as a mixin?
      #
      class Unary < self
        include Concord.new(:operand)

        # Unary negation
        class Negation < self

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
