class Ducktrap

  # Noop ducktrap with fixed inverse
  class Inverse < self
    include Composition.new(:inverse)

    # Return result
    #
    # @param [Object] input
    #
    # @return [Result]
    #
    # @api private
    #
    def run(input)
      Result::Static.new(self, input, input)
    end

  private

    # Perform pretty dump
    #
    # @return [self]
    #
    def dump(output)
      output.name(self)
      output.nest('inverse:', inverse)
    end

  end
end
