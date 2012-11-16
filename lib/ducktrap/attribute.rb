class Ducktrap
  # Abstract base class for ducktrap with attribute as result
  class Attribute < self
    include AbstractClass
    include Equalizer.new(:name)

    def run(input)
      result_klass.new(self, input)
    end

    # Perform pretty dump
    #
    # @return [self]
    #
    # @api private
    #
    def pretty_dump(output=Formatter.new)
      output.name(self)
      output.nest('postprocessor:', postprocessor)
      self
    end

    attr_reader :name
    attr_reader :postprocessor

    def initialize(name, postprocessor=Noop.instance)
      @name, @postprocessor = name, postprocessor
    end

    def self.build(name, &block)
      postprocessor = Noop.instance

      if block
        postprocessor = Ducktrap::Block.build(&block)
      end

      new(name, postprocessor)
    end

    class Result < Ducktrap::Result

      attr_reader :name

      def process
        value = process_value
        if(value.kind_of?(Error))
          return Error.new(context, value)
        end

        result = postprocessor.run(value)

        unless result.successful?
          return Error.new(context, value)
        end

        NamedValue.new(name, value)
      end

      def postprocessor
        context.postprocessor
      end

      def name
        context.name
      end

    end

    class ParamsHash < self
      register :attribute_from_params_hash

      def inverse 
        Ducktrap::ParamsHash::Attribute.new(name, postprocessor.inverse)
      end

      class MissingKeyError < Ducktrap::Error
        def initialize(context, input, key)
          @key = key
          super(context, input)
        end
      end

      class Result < Ducktrap::Attribute::Result
        def key
          name.to_s
        end

        def process_value
          input.fetch(key) do
            return MissingKeyError.new(context, input, key)
          end
        end
      end
    end
  end
end
