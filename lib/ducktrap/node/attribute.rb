module Ducktrap
  class Node
    # Node for specific named attribute
    class Attribute < self
      include Nullary, Concord::Public.new(:name)

      register :attribute

      # Evaluator for attribute nodes
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
