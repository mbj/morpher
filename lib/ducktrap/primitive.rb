class Ducktrap

  class Primitive < self
    include Composition.new(:primitive)

    register :primitive

    # Run ducktrap in input
    #
    # @param [Object] input
    #
    # @return [Result]
    #
    # @api private
    #
    def run(input)
      unless input.kind_of?(primitive)
        return Result::Invalid.new(self, input)
      end

      Result::Static.new(self, input, input)
    end

    # Perfrom pretty dump
    #
    # @return [self]
    #
    # @api private
    #
    def pretty_dump(output=Formatter.new)
      output.puts(self.class.name)
      output = output.indent
      output.puts("primitive: #{primitive}")
      self
    end

    # Return inverse ducktrap
    #
    # @return [Ducktrap]
    #
    # @api private
    #
    def inverse; Inverse.new(self); end
    
    # Build ducktrap
    #
    # @return [Ducktrap]
    #
    # @api private
    #
    def self.build(*args)
      new(*args)
    end
  end
end
