class Transformator

  # Transformator that fails on expected primitive mismatch
  class Primitive < self

    # Error for invalid primitives
    class InvalidPrimitive < Error

      # Return expected primitive
      #
      # @return [Class]
      #
      # @api private
      #
      attr_reader :expected_primitive

      # Return actual primitive
      #
      # @return [Class]
      #
      # @api private
      #
      attr_reader :actual_primitive

    private
      
      # Initialize object
      #
      # @param [Class] expected_primitive
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(expected_primitive, actual_primitive)
        @expected_primitive, @actual_primitive = expected_primitive, actual_primitive
      end
    end

    # Builder for primitive transformator
    class Builder < ::Transformator::Builder

      # Run transformator
      #
      # @param [Object] input
      #
      # @return [Transformator::Primitive]
      #
      # @api private
      #
      def run(input)
        Primitive.new(input, @primitive)
      end

    private

      # Initialize object
      #
      # @param [Class] primitive
      #
      # @api private
      #
      def initialize(primitive)
        @primitive = primitive
      end
    end

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
    def initialize(expected_primitive)
      @expected_primitive = expected_primitive
    end

    # Load input
    #
    # @return [Object]
    #   input in case it is kind of primitive
    #
    # @return [Undefined] 
    #   otherwise
    #
    def load
      if primitive?
        input
      else
        error(invalid_primitive_error)
        Undefined
      end
    end

    # Return inalid primitive error
    #
    # @return [InvalidPrimitiveError]
    #
    # @api private
    #
    def invalid_primitive_error
      InvalidPrimitiveError.new(expected_primitive, primitive)
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
