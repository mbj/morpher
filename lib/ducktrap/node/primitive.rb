module Ducktrap
  class Node
    # Primitive check
    class Primitive < self
      include Concord::Public.new(:primitive)

      register :primitive

      # Run ducktrap in input
      #
      # @param [Object] input
      #
      # @return [Evaluator]
      #
      # @api private
      #
      def run(input)
        unless input.kind_of?(primitive)
          return Evaluator::Invalid.new(self, input)
        end

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
        output.attribute(:primitive, primitive)
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
