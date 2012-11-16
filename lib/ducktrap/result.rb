class Ducktrap

  # Abstract base class for mutation result
  class Result
    include AbstractClass, Adamantium::Flat, Equalizer.new(:context, :input, :output)

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

    # Return input
    #
    # @return [Object]
    #
    # @api private
    #
    attr_reader :input

    # Return output
    #
    # @return [Object]
    #
    # @api private
    #
    attr_reader :output

    # Return context
    #
    # @return [Object]
    #
    # @api private
    #
    attr_reader :context

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

    # Initialize object
    #
    # @param [Object] input
    #   the input to dload
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(context, input)
      @context, @input = context, input
    end

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
