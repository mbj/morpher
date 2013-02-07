class Ducktrap

  class Primitive < self
    include Composition.new(:primitive)

    register :primitive

    def run(input)
      unless input.kind_of?(primitive)
        return Result::Invalid.new(self, input)
      end

      Result::Static.new(self, input, input)
    end

    def pretty_dump(output=Formatter.new)
      output.puts(self.class.name)
      output = output.indent
      output.puts("primitive: #{primitive}")
      self
    end

    def inverse; Inverse.new(self); end

    def self.build(*args)
      new(*args)
    end
  end
end
