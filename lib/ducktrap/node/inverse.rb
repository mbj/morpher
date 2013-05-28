module Ducktrap
  class Node
    # Noop ducktrap with fixed inverse
    class Inverse < self
      include Concord::Public.new(:inverse)

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
        Evaluator::Noop.new(self, input)
      end

    private

      # Perform pretty dump
      #
      # @return [undefined]
      #
      # @api private
      #
      def dump(output)
        output.name(self)
        output.nest(:inverse, inverse)
      end

    end # Inverse
  end # Node
end # Ducktrap
