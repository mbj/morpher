class Ducktrap

  # Noop ducktrap with fixed inverse
  class Inverse < self
    include Equalizer.new(:inverse)

    # Return result for input
    #
    # @return [Result::Noop]
    #
    # @api private
    #
    def run(input)
      Result::Noop.new(self, input)
    end

    # Perform pretty dump
    #
    # @return [self]
    #
    def pretty_dump(output=Formatter.new)
      output.name(self)
      output.nest('inverse:', inverse)
      self
    end

    # Return iverse
    #
    # @api private
    #
    # @return [Ducktrap]
    #
    attr_reader :inverse

  private

    # Initialize object
    #
    # @param [Ducktrap] inverse
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(inverse)
      @inverse = inverse
    end
  end
end
