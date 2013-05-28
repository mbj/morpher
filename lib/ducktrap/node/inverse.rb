module Ducktrap
  class Node
    # Noop ducktrap with fixed inverse
    class Inverse < self
      include Concord::Public.new(:operand)

      register :inverse

      # Return inverse node
      #
      # @return [Forward]
      #
      # @api private
      #
      def inverse
        Forward.new(operand)
      end

      # Return evaluator
      #
      # @param [Object] input
      #
      # @return [Evaluator]
      #
      # @api private
      #
      def call(input)
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
        output.nest(:operand, operand)
      end

    end # Inverse
  end # Node
end # Ducktrap
