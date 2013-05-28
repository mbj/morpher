module Ducktrap
  class Node
    # Noope node, returns input as output
    class Invalid < self
      include Singleton

      # Run ducktrap
      #
      # @param [Object] input
      # 
      # @return [Evaluator]
      #
      # @api private
      #
      def call(input)
        Evaluator::Invalid.new(self, input)
      end

      # Return inverse ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def inverse; self; end

    end # Invalid
  end # Node
end # Ducktrap
