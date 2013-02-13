class Ducktrap

  # Abstract base class for mutation result
  class Result
    include AbstractType, Adamantium::Flat, Composition.new(:context, :input)

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

    # Return output
    #
    # @return [Object]
    #
    # @api private
    #
    attr_reader :output

    # Return error
    #
    # @return [Error]
    #
    # @api private
    #
    def error
      Error.new(context, input)
    end
    memoize :error

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

    # Dump object
    #
    # @param [Formatter] output
    #
    # @return [self]
    #
    # @api private
    #
    def dump(output)
      output.puts(self.class.name)
      output = output.indent
      output.puts("input: #{input.inspect}")
      if successful?
        output.puts("output: #{output.inspect}")
      else
        output.nest('output:', output)
      end
      output.nest('contest:', context)
      self
    end

  end
end
