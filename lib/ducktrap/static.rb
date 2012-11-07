class Ducktrap
  class Static < self
    include Equalizer.new(:value, :inverse_value)

    attr_reader :value, :inverse_value

    def run(input)
      Result::Static.new(self, @value, @value)
    end

    def inverse
      Static.new(@inverse_value, @value)
    end

    def initialize(value, inverse_value)
      @value, @inverse_value = value, inverse_value
    end
  end
end
