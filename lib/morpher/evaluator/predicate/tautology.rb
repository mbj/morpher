module Morpher
  class Evaluator
    class Predicate

      # Evaluator for trautology
      class Tautology < self
        include Nullary, Transitive

        register :true

        # Call predicate evaluator
        #
        # @param [Object] _input
        #
        # @return [true]
        #
        # @api private
        #
        def call(_input)
          true
        end

        # Return inverse evaluator
        #
        # @return [Evaluator]
        #
        # @api private
        #
        def inverse
          Contradiction.new
        end

        def self.build(_compiler, _node)
          new
        end

      end # Tautology
    end # Predicate
  end # Evaluator
end # Morpher
