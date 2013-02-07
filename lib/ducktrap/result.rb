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

    # Perform a pretty dump
    #
    # @param [Formatter] io
    #
    # @return [self]
    #
    def pretty_dump(io=Formatter.new)
      io.puts(self.class.name)
      io = io.indent
      io.puts("input: #{input.inspect}")
      if successful?
        io.puts("output: #{output.inspect}")
      else
        io.nest('output:', output)
      end
      io.nest('contest:', context)
      self
    end

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

  end
end
