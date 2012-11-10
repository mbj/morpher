class Ducktrap
  class Anima < self
    include Equalizer.new(:model)

    def pretty_dump(output)
      output.puts(self.class.name)
      output = output.indent
      output.puts("model: #{model}")
    end

    attr_reader :model

    def initialize(model)
      @model = model
    end

    class AttributesHash < self
      register :anima_from_attributes_hash

      def inverse; Ducktrap::AttributesHash::Anima.new(model); end

      def run(input)
        result_klass.new(self, input, model)
      end

      def self.build(*args)
        new(*args)
      end

      class Result < Ducktrap::Result
      private
        def process
          @model.new(input)
        rescue ::Anima::AttributeError
          error
        end

        def initialize(context, input, model)
          @model = model
          super(context, input)
        end
      end
    end
  end
end
