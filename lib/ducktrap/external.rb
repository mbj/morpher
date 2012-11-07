class Ducktrap
  class External < self
    register :extern

    def inverse
      self.class.new(inverse_block, forward_block)
    end

    def run(input)
      Result::Static.new(self, input, @forward_block.call(input))
    end

    attr_reader :forward_block, :inverse_block

    def initialize(forward_block, inverse_block)
      @forward_block, @inverse_block = forward_block, inverse_block
    end

    def self.build(&block)
      Builder.new(self, &block).object
    end

    class Builder < Ducktrap::Builder
      def forward(&block)
        @forward_block = block
      end

      def inverse(&block)
        @inverse_block = block
      end

      def forward_block
        @forward_block || raise("No forward block specified!")
      end

      def inverse_block
        @inverse_block || raise("No inverse block specified!")
      end

      def object
        klass.new(forward_block, inverse_block)
      end
    end
  end
end
