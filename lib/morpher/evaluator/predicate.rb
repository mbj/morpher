module Morpher
  class Evaluator
    # Abstract namespace class for predicate evaluators
    class Predicate < self

      # Return inverse evaluator
      #
      # @return [Evaluator]
      #
      # @api private
      #
      def inverse
        Not.new(self)
      end

      class Not < self
        include Concord.new(:operand)

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

      end # Not
    end # Predicate
  end # Evaluator
end # Morpher
