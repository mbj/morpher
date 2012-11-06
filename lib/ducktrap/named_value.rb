class Ducktrap
  # A value with a name
  class NamedValue
    include Equalizer.new(:name, :value)

    attr_reader :name
    attr_reader :value

    def initialize(name, value)
      @name, @value = name, value
    end
  end
end
