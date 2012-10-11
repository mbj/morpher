class Ducktrap

  # Ducktrap to enfoce primitive type
  class Primitive < self
    include Equalizer.new(:primitive)

    register :primitive

    # Run ducktrap
    #
    # @param [Object] input
    #
    # @return [Result::Primitive]
    #
    # @api private
    #
    def run(input)
      Result::Primitive.new(input, @primitive)
    end

    # Return primitive
    #
    # @return [Class]
    #
    # @api private
    #
    attr_reader :primitive

  private

    # Initialize object
    #
    # @param [Class] primitive
    #
    # @api private
    #
    def initialize(primitive)
      @primitive = primitive
    end
  end
end
