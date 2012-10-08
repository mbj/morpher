class Mutator

  # Abstract class for mutator that results in single attribute
  class Attribute < self
    include AbstractClass

    # Return name
    #
    # @return [Symbol] name
    #
    # @api private
    #
    attr_reader :name

    # Return mutator
    #
    # @return [Mutator]
    #
    # @api private
    #
    attr_reader :mutator

    # Run mutator on input
    #
    # @param [Object] input
    #
    # @return [Result::Attribute]
    #
    # @api private
    #
    def run(input)
      self.class::RESULT.new(input, name, mutator)
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
      @mutator = Block.new(&block)
    end

    class Params < self
      include Equalizer.new(:name, :mutator)

      RESULT = Result::Attribute::Params
      register :attribute_from_params
    end
  end
end
