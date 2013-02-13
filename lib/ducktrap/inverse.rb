class Ducktrap

  # Noop ducktrap with fixed inverse
  class Inverse < self
    include Composition.new(:inverse)

    # Return result for input
    #
    # @return [Result::Noop]
    #
    # @api private
    #
    def run(input)
      Result::Noop.new(self, input)
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
