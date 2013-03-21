module Ducktrap
  class Evaluator
    # Evaluator that always returns errors
    class Invalid < self

      # Return output
      #
      # @return [Evaluator]
      #
      # @api private
      #
      attr_reader :output

      # Initialize object
      #
      # @param [Ducktra] context
      # @param [Object] input
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(context, input)
        super(context, input)
        @output = error
      end

    end
  end
end
