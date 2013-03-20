module Ducktrap
  class Node
    # Noop ducktrap with fixed inverse
    class Inverse < self
      include Concord.new(:inverse)

      register :inverse

      # Return evaluator
      #
      # @param [Object] input
      #
      # @return [Evaluator]
      #
      # @api private
      #
      def run(input)
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
