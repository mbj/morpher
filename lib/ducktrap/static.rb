class Ducktrap
  class Static < self
    include Composition.new(:value, :inverse_value)

    def run(input)
      Result::Static.new(self, value, value)
    end

    def inverse
      Static.new(inverse_value, value)
    end
  end
end
