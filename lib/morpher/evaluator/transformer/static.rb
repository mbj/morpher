# encoding: UTF-8

module Morpher
  class Evaluator
    class Transformer
      class Static < self
        include Parameterized, Nullary, Intransitive

        register :static

        # Call evaluator with input
        #
        # @param [Object] _input
        #
        # @return [Object]
        #   alwasys returns the param
        #
        def call(_input)
          param
        end

      end # Static
    end # Transformer
  end # Evaluator
end # Morpher
