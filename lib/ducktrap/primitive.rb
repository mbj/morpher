class Ducktrap
  class Inverse < self
    def run(input)
      Result::Noop.new(self, input)
    end

    attr_reader :inverse

    def initialize(inverse)
      @inverse = inverse
    end
  end

  class Primitive < self
    include Equalizer.new(:primitive)

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

    attr_reader :primitive

    def self.build(*args)
      new(*args)
    end

    def initialize(primitive)
      @primitive = primitive
    end
  end
end
