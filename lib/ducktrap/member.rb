class Ducktrap
  class Member < self
    include Unary

    # Return index
    #
    # @return [Fixnum]
    #
    # @api private
    #
    attr_reader :index

    # Initialize object 
    #
    # @param [Fixnum] index
    # @param [Ducktrap] operand
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(index, operand)
      @index = index
      super(operand)
    end

    # Return inverse ducktrap
    #
    # @return [Ducktrap]
    #
    # @api private
    #
    def inverse; self.class.new(index, operand.inverse); end

  private

    # Perform pretty dump
    #
    # @param [Formatter] output
    #
    # @return [undefined]
    #
    # @api private
    #
    def dump(output)
      output.puts("- #{@index}: #{self.class.name}")
      output.indent.nest('operand:', operand)
    end

    # Error of member ducktrap
    class MemberError < Ducktrap::Error

      # Return member error
      #
      # @return [Error]
      #
      # @api private
      #
      attr_reader :error

      # Initialize object
      #
      # @param [Ducktrap] context
      # @param [Object] input
      # @param [Error] error
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(context, input, error)
        @error = error
        super(context, input)
      end

    private

      # Dump object
      #
      # @param [Formatter] output 
      #
      # @return [undefined]
      #
      # @api private
      #
      def dump(output)
        output.name(self)
        output = output.indent
        output.puts("input: #{input.inspect}")
        output.nest('error:', error)
        output.puts('context:', context)
        self
      end
    end

    # Result of member ducktrap
    class Result < Unary::Result

    private

      # Process input 
      #
      # @return [Object]
      #
      # @api private
      #
      def process
        result = operand.run(input)
        unless result.successful?
          return MemberError.new(context, input, result.output)
        end
        result.output
      end

    end
  end
end
