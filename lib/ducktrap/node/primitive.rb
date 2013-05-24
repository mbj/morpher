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

        Evaluator::Static.new(self, input, input)
      end

      # Return inverse ducktrap
      #
      # @return [Ducktrap]
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
        self
      end
      
      # Build ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def self.build(*args)
        new(*args)
      end
    end
  end
end
