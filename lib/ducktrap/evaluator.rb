module Ducktrap

  # Abstract base class for transform evaluator
  class Evaluator
    include AbstractType, Adamantium::Flat, PrettyDump, Concord::Public.new(:context, :input)

    # Test if conversion was successful
    #
    # @return [true]
    #   if conversion was successful
    #
    # @return [false]
    #   otherwise
    #
    # @api private
    #
    def successful?
      !output.kind_of?(Error)
    end

    # Assert evaluator is successful
    #
    # @return [self]
    #   if successful
    #
    # @raise [FailedTransformationError]
    #   otherwise
    #
    # @api private
    #
    def assert_successful
      unless successful?
        raise FailedTransformationError.new(self)
      end
      self
    end

    # Return output
    #
    # @return [Object]
    #
    # @api private
    #
    attr_reader :output

    # Return output
    #
    # @return [Object]
    #
    # @api private
    #
    def output
      process
    end
    memoize :output

  private

    # Calculate result
    #
    # @return [Object]
    #   if successful
    #
    # @return [Error]
    #   otherwise
    #  
    # @api private
    #
    abstract_method :process
    private :process

    # Return error
    #
    # @return [Error]
    #
    # @api private
    #
    def error
      Error.new(context, input)
    end

    # Return error with message
    #
    # @param [Error::Message]
    #
    # @return [Error]
    #
    # @api private
    #
    def exception(exception)
      Error::Exception.new(context, input, exception)
    end

    # Return nested error
    #
    # @return [Error::Nested]
    #
    # @api private
    #
    def nested_error(error)
      Error.new(error, input)
    end

    # Dump object
    #
    # @param [Formatter] formatter
    #
    # @return [self]
    #
    # @api private
    #
    def dump(formatter)
      formatter.name(self)
      formatter.attribute(:input, input)
      if successful?
        formatter.attribute(:output, output)
      else
        formatter.nest(:error, output)
      end
      formatter.nest('context:', context)
      self
    end

  end
end
