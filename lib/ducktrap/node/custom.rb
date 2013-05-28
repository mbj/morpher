module Ducktrap
  class Node
    # Custom, user defined node
    class Custom < self
      include Concord::Public.new(:forward_block, :inverse_block)

      register :custom

      # FIXME: Remove this after a while
      register :extern

      # Return inverse
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def inverse
        self.class.new(inverse_block, forward_block)
      end

      # Run with input
      #
      # @param [Object] input
      #
      # @return [Evaluator]
      #
      # @api private
      #
      def call(input)
        Evaluator::Static.new(self, input, forward_block.call(input))
      end

    private

      # Dump object
      #
      # @param [Formatter] output
      #
      # @return [undefined]
      #
      # @api private
      #
      def dump(output)
        output.name(self)
        output.attribute(:forward, forward_block)
        output.attribute(:inverse, inverse_block)
      end

      # Build external ducktrap
      #
      # @return [External]
      #
      # @api private
      #
      def self.build(&block)
        Builder.new(self, &block).object
      end

      # Builder for external ducktrap
      class Builder < Ducktrap::Builder

        # Capture forward block
        #
        # @return [self]
        #
        # @api private
        #
        def forward(&block)
          @forward_block = block
          self
        end

        # Capture inverse block
        #
        # @return [self]
        #
        # @api private
        #
        def inverse(&block)
          @inverse_block = block
          self
        end

        # Return ducktrap
        #
        # @return [Ducktrap]
        #
        # @api private
        #
        def object
          klass.new(forward_block, inverse_block)
        end

      private

        # Return block
        #
        # @return [Proc]
        #
        # @api private
        #
        def forward_block
          @forward_block || raise('No forward block specified!')
        end

        # Return inverse block
        #
        # @return [Proc]
        #
        # @api private
        #
        def inverse_block
          @inverse_block || raise('No inverse block specified!')
        end

      end # Builder

    end # Custom
  end # Node
end # Ducktrap
