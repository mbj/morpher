module Ducktrap
  class Node
    # Noope node, returns input as output
    class Noop < self
      include Singleton

      # Run ducktrap
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

      # Return inverse ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def inverse; self; end
    end
  end
end
