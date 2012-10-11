class Ducktrap
  class Result

    # Mutation result for anima objects
    class Anima < self

      equalize :model

      # Return model
      #
      # @return [Class] model
      #
      # @api private
      #
      attr_reader :model

    private

      # Calculate result
      #
      # @return [Object]
      #   if object could be loaded
      #
      # @return [Undefined]
      #   otherwise
      #
      # @api private
      #
      def result
        model.new(input)
      rescue ::Anima::AttributeError => exception
        Undefined
      end

      # Initialize object
      #
      # @param [Object] input
      # @param [Class] model
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(input, model)
        @model = model
        super(input)
      end
    end
  end
end
