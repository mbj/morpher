class Ducktrap

  # Abstract class for ducktrap that results in single attribute
  class Attribute < self
    include AbstractClass

    # Return name
    #
    # @return [Symbol] name
    #
    # @api private
    #
    attr_reader :name

    # Return ducktrap
    #
    # @return [Ducktrap]
    #
    # @api private
    #
    attr_reader :ducktrap

    # Run ducktrap on input
    #
    # @param [Object] input
    #
    # @return [Result::Attribute]
    #
    # @api private
    #
    def run(input)
      self.class::RESULT.new(input, name, ducktrap)
    end

  private

    # Initialize object
    #
    # @param [Symbol] name
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(name, &block)
      @name = name
      @ducktrap = NAry::Block.new(&block)
    end

    class Params < self
      include Equalizer.new(:name, :ducktrap)

      RESULT = Result::Attribute::Params
      register :attribute_from_params
    end
  end
end
