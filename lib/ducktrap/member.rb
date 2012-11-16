class Ducktrap
  class Member < self
    include Unary

    attr_reader :index

    def initialize(index, operand)
      @index = index
      super(operand)
    end

    def inverse; self.class.new(index, operand.inverse); end

    # Perform pretty dump
    #
    # @return [self]
    #
    # @api private
    #
    def pretty_dump(output=Formatter.new)
      output.puts("- #{@index}: #{self.class.name}")
      output.indent.nest('operand:', operand)
      self
    end

    class MemberError < Ducktrap::Error
      attr_reader :error

      def initialize(context, input, error)
        @error = error
        super(context, input)
      end

      # Perform pretty dump
      #
      # @return [self]
      #
      # @api private
      #
      def pretty_dump(output=Formatter.new)
        output.name(self)
        output = output.indent
        output.puts("input: #{input.inspect}")
        output.nest('error:', error)
        output.puts('context:', context)
        self
      end
    end

    class Result < Unary::Result

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
