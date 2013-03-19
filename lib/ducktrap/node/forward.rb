class Ducktrap
  class Node
    # Ducktrap with noop inverse
    class Forward < self
      include Unary, Concord.new(:operand)

      register :forward

      # Return result
      #
      # @param [Object] input
      #
      # @return [Result]
      #
      # @api private
      #
      def inverse

        Result::Static.new(self, input, input)
      end

    private

      # Perform pretty dump
      #
      # @return [self]
      #
      def dump(output)
        output.name(self)
        output.nest('inverse:', inverse)
      end

    end
  end
end
