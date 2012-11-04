class Ducktrap
  # Ducktrap that returns last result of a chain and stops on first failure.
  # Acts like AND with multiple inputs.
  class Block < self
    include NAry

    register :block

    def inverse
      self.class.new(body.map(&:inverse).reverse)
    end

    class BlockMemberError < Ducktrap::Error
      def pretty_dump(output = Formatter.new)
        output.puts(self.class.name)
        output = output.indent
        output.puts("input: #{input.inspect}")
        output.puts("member:")
        member.pretty_dump(output.indent)
        output.puts("context:")
        context.pretty_dump(output.indent)
        output.puts("input: #{input.inspect}")
      end

      attr_reader :member

      def initialize(context, input, member)
        @member = member
        super(context, input)
      end
    end

    # Result of chained ducktraps
    class Result < Ducktrap::Result
      include NAry::Result

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
      def process
        original_input = input
        body.inject(original_input) do |input, ducktrap|
          result = ducktrap.run(input)

          unless result.successful?
            return BlockMemberError.new(context, original_input, result.output)
          end

          result.output
        end
      end
    end
  end
end
