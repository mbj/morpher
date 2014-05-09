# encoding: UTF-8

module Morpher
  class Evaluator
    class Transformer

      # Identity transformer which always returns +input+
      class Input < self
        include Nullary, Transitive

        register :input

        # Call evaluator with input
        #
        # @param [Object] input
        #
        # @return [Object]
        #   always returns input
        #
        # @api private
        #
        def call(input)
          input
        end

        INSTANCE = new

        def inverse
          INSTANCE
        end

      end # Static
    end # Transformer
  end # Evaluator
end # Morpher
