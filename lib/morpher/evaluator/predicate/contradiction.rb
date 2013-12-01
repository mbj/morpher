module Morpher
  class Evaluator
    class Predicate

      # Evaluator for contradiction
      class Contradiction < self
        include Nullary

        register :false

        # Call predicate evaluator
        #
        # @param [Object] _input
        #
        # @return [false]
        #
        # @api private
        #
        def call(_input)
          false
        end

      end # Contradiction
    end # Predicate
  end # Evaluator
end # Morpher
