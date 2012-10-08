class Transformator

  # Abstract base class for transformation errors
  class Error < RuntimeError 
    include AbstractClass, Immutable

    # Abstract base class for loading errors that are caught exceptions
    class Wrapper < Error

      # Return wrapped exception
      #
      # @param [Exception] exception
      #
      # @api private
      #
      attr_reader :wrapped_exception

    private

      # Initialize object
      #
      # @param [Exception] exception
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(wrapped_exception)
        super("Caught exception #{wrapped_exception.class}: #{wrapped_exception.message}")
        @wrapped_exception = wrapped_exception
      end
    end
  end
end
