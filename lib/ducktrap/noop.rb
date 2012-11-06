class Ducktrap
  class Noop < self
    include Nullary

    def run(input)
      Result::Static.new(self, input, input)
    end

    def inverse; self; end
  end
end
