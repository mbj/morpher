class Ducktrap
  class Noop < self
    def run(input)
      Result::Static.new(input, input)
    end

    def invert
      @inverse
    end

    def initialize(inverse)
      @inverse = inverse
    end
  end

  class Primitive < self
    include Equalizer.new(:primitive)

    register :primitive

    def run(input)
      output = input.kind_of?(primitive) ? input : Undefined
      Result::Static.new(input, output)
    end

    def invert; self; end

    attr_reader :primitive

    def initialize(primitive)
      @primitive = primitive
    end
  end
end
