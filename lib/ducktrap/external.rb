class Ducktrap
  class External < self
    register :extern

    include Equalizer.new(:block, :inverse_block)

    # Return inverse
    #
    # @return [Ducktrap]
    #
    # @api private
    #
    def inverse
      self.class.new(inverse_block, block)
    end

    # Run with input
    #
    # @param [Object] input
    #
    # @return [Result]
    #
    # @api private
    #
    def run(input)
      Result::Static.new(self, input, @block.call(input))
    end

    # Return block
    #
    # @return [Proc]
    #
    # @api private
    #
    attr_reader :block
    
    # Return inverse block
    #
    # @return [Proc]
    #
    # @api private
    #
    attr_reader :inverse_block

    # Initialize object
    #
    # @param [Proc] block
    # @param [Proc] inverse
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(block, inverse_block)
      @block, @inverse_block = block, inverse_block
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
        @block = block
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

    private

      # Return block
      #
      # @return [Proc]
      #
      # @api private
      #
      def block
        @block || raise("No forward block specified!")
      end

      # Return inverse block
      #
      # @return [Proc]
      #
      # @api private
      #
      def inverse_block
        @inverse_block || raise("No inverse block specified!")
      end

      # Return ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def object
        klass.new(block, inverse_block)
      end

    end
  end
end
