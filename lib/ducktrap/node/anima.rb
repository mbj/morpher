module Ducktrap
  class Node
    # Base class for anima nodes
    class Anima < self
      include Unary, Concord.new(:operand, :model)

    private

      # Perform pretty dump
      #
      # @param [Formatter] output
      #
      # @return [undefined]
      #
      # @api private
      #
      def dump(output)
        output.name(self)
        output.attribute(:model, model)
      end

      class Result < Unary::Result

      private

        # Return model
        #
        # @return [Class:Anima]
        #
        # @api private
        #
        def model
          context.model
        end

      end
    end
  end
end
