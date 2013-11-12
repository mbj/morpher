module Ducktrap
  class Node

    # Identity check
    class Identity < self
      include Equalizer.new

      register :identity

      # Run ducktrap in input
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

      # Return inverse ducktrap
      #
      # @return [self]
      #
      # @api private
      #
      def inverse; self end

    private

      # Perfrom pretty dump
      #
      # @param [Formatter] output
      #
      # @return [undefined]
      #
      # @api private
      #
      def dump(output)
        output.name(self)
      end

      class << self

        # Build node
        #
        # @return [node]
        #
        # @api private
        #
        alias_method :build, :new

      end

    end # Primitive
  end # node
end # Ducktrap

