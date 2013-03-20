module Ducktrap
  class Node
    # Ducktrap with noop inverse
    class Forward < self
      include Unary, Concord.new(:operand)

      register :forward

      # Return evaluator
      #
      # @param [Object] input
      #
      # @return [Evaluator]
      #
      # @api private
      #
      def inverse

        Evaluator::Static.new(self, input, input)
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
