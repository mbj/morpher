module Morpher
  class Evaluator
    class Transformer
      # Transformer to return a specific attribute of input
      class Attribute < self
        include Parameterized, Nullary, Intransitive

        register :attribute

        # Call evaluator
        #
        # @param [Object] input
        #
        # @return [Object]
        #
        # @api private
        #
        def call(input)
          input.public_send(param)
        end

      end # Attribute
    end # Transformer
  end # Evaluator
end # Morpher
