class Ducktrap
  # Abstract base class for ducktrap with attribute as result
  class Attribute < self
    include AbstractClass

    class Attribute
      attr_reader :name
      attr_reader :value
      include Equalizer.new(:name, :value)

      def initialize(name, value)
        @name, @value = name, value
      end
    end

    def run(input)
      result_klass.new(input, self)
    end

    attr_reader :name

    def initialize(name, *args, &block)
      @name = name
      super(*args, &block)
    end

    class Result < Ducktrap::Result

      attr_reader :name

      def initialize(input, name)
        @name = name
        super(input)
      end
    end
  end
end
