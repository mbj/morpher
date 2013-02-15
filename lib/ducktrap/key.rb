class Ducktrap
  # Base class for ducktraps that manipulate keys
  class Key < self
    include Unary, Equalizer.new(:operand, :key)

    # Return key
    #
    # @return [Object]
    # 
    # @api private
    #
    attr_reader :key

    # Initiaize object
    #
    # @param [Ducktrap] operand
    # @param [Object] key
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(operand, key)
      @key = key
      super(operand)
    end

    # Base class for key results
    class Result < Unary::Result

    private

      # Return key to operate on
      #
      # @return [Object]
      #
      # @api private
      #
      def key
        context.key
      end
    end

  end
end
