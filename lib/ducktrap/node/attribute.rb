module Ducktrap
  class Node
    class Attribute < self
      include Nullary, Concord.new(:name)

      register :attribute

      class Evaluator < Nullary::Evaluator

      private

        # Return name of attribute
        #
        # @return [Symbol]
        #
        # @api private
        #
        def name
          context.name
        end

        # Return attribute
        #
        # @return [Object]
        #
        # @api private
        #
        def process
          input.public_send(name)
        end
      end
    end
  end
end
