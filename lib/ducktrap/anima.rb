class Ducktrap
  class Anima < self
    include Unary, Composition.new(:operand, :model)

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
