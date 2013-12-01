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
        Unary::Negation.new(self)
      end

    end # Predicate
  end # Evaluator
end # Morpher
