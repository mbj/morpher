class Mutator
  class Result

    # Mutator result that fails on expected primitive mismatch
    class Primitive < self

      # Return expected primitive
      #
      # @return [Class]
      #
      # @api private
      #
      attr_reader :expected_primitive

      # Return acutal primitive
      #
      # @return [Class]
      #
      # @api private
      #
      def actual_primitive
        input.class
      end

    private

      # Initialize object
      #
      # @param [Object] input
      # @param [Class] expected_primitive
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(input, expected_primitive)
        @expected_primitive = expected_primitive
        super(input)
      end

      # Calculate result
      #
      # @return [Object]
      #   input in case it is kind of primitive
      #
      # @return [Undefined] 
      #   otherwise
      #
      def result
        if primitive?
          input
        else
          Undefined
        end
      end

      # Test if input is kind of primitive
      #
      # This method does NOT accept subclasses.
      #
      # @return [true]
      #   if input is kind of primitive
      #
      # @return [false]
      #   otherwise
      #
      # @api private
      #
      def primitive?
        expected_primitive == actual_primitive
      end

    end
  end
end
