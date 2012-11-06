class Ducktrap
  class Member < self
    include Unary

    attr_reader :index

    def initialize(index, operand)
      @index = index
      super(operand)
    end

    def inverse; self.class.new(index, operand.inverse); end

    def pretty_dump(output)
      output.puts("- #{@index}: #{self.class.name}")
      output = output.indent
      output.puts("operand:")
      operand.pretty_dump(output.indent)
    end

    class MemberError < Ducktrap::Error
      attr_reader :error

      def initialize(context, input, error)
        @error = error
        super(context, input)
      end

      def pretty_dump(output)
        output.puts(self.class.name)
        output = output.indent
        output.puts("input: #{input.inspect}")
        output.puts("error:")
        error.pretty_dump(output.indent)
        output.puts("context:")
        context.pretty_dump(output.indent)
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
