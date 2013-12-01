module Morpher
  class Evaluator
    class Predicate
      # Evaluator for predicates that tests for semantical equality
      class EQL < self
        include Nullary, Parameterized

        register :eql

        # Call evaluator
        #
        # @param [Object] input
        #
        def call(input)
          param.eql?(input)
        end

      end # EQL
    end # Predicate
  end # Evaluator
end # Morpher
