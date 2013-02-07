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

    # Perform pretty dump
    #
    # @return [self]
    #
    def pretty_dump(output=Formatter.new)
      output.name(self)
      output.nest('inverse:', inverse)
      self
    end

  end
end
