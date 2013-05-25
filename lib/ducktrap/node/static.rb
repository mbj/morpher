module Ducktrap
  class Node
    # Transformer with static output
    class Static < self
      include Nullary, Concord::Public.new(:value, :inverse_value)

      register :static

      # Run ducktrap on input
      #
      # @param [Object] input
      #
      # @return [Evaluator]
      #
      # @api private
      #
      def run(input)
        Evaluator::Static.new(self, input, value)
      end

      # Return inverse ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def inverse
        Static.new(inverse_value, value)
      end

    end # Static
  end # node
end # Ducktrap
