class Ducktrap
  class Result

    # Static result with input as output
    class Noop < self

      # Return output
      #
      # @return [Object]
      #
      # @api private
      #
      attr_reader :output

      # Initialize object
      #
      # @param [Ducktrap] context
      # @param [Object] input
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(context, input)
        super(context, input)
        @output = input
      end

    end

    # Static result with static output
    class Static < self

      # Return output
      #
      # @return [Object]
      #
      # @api private
      #
      attr_reader :output

      # Initialihe object
      #
      # @param [Ducktrap] context
      # @param [Object] input
      # @param [Object] output
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(context, input, output)
        super(context, input)
        @output = output
      end

    end
  end
end
