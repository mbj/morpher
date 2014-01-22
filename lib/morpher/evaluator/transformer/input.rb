# encoding: UTF-8

module Morpher
  class Evaluator
    class Transformer
      class Input < self
        include Nullary, Intransitive

        register :input

        # Call evaluator with input
        #
        # @param [Object] input
        #
        # @return [Object]
        #   always returns input
        #
        def call(input)
          input
        end

      end # Static
    end # Transformer
  end # Evaluator
end # Morpher
