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
      def initialize(_context, _input)
        super
        @output = error
      end

    end # Invalid
  end # Evaluator
end # Ducktrap
