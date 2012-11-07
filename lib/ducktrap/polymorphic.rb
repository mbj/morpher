class Ducktrap
  # Namespace for polymorphic mappings.
  class Polymorphic < self
    class Type < self
      include Unary

      attr_reader :key
      attr_reader :model

      def initialize(key, model, operand)
        @key, @model = key, model
        super(operand)
      end

      def pretty_dump(output)
        output.puts(self.class.name)
        output = output.indent
        output.puts("key: #{key.inspect}")
        output.puts("model: #{model.inspect}")
        output.puts("operand:")
        operand.pretty_dump(output.indent)
      end

      class Loader < self
        def inverse
          Polymorphic::Type::Dumper.new(key, model, operand.inverse)
        end

        class Result < Unary::Result
          def process
            body = input.fetch('body')
            result = operand.run(body)
            unless result.successful?
              raise
            end
            result.output
          end
        end
      end

      class Dumper < self
        def inverse
          Polymorphic::Type::Loader.new(key, model, operand.inverse)
        end

        class Result < Unary::Result
          def process
            result = operand.run(input)
            unless result.successful?
              return NAry::MemberError.new(context, input, result)
            end

            { 'type' => context.key, 'body' => result.output }
          end
        end
      end
    end

    class Map < self
      include NAry

      class Loader < self
        def mapping
          body.each_with_object({}) do |context, hash|
            hash[context.key] = context
          end
        end
        memoize :mapping

        def mapper(key)
          mapping.fetch(key)
        end

        def inverse
          Polymorphic::Map::Dumper.new(body.map(&:inverse))
        end

        class Result < NAry::Result
          def process
            mapper = context.mapper(input.fetch('type'))
            result = mapper.run(input)
            unless result.successful?
              return NAry::MemberError.new(context, input, result)
            end
            result.output
          end
        end
      end

      class Dumper < self
        def mapping
          body.each_with_object({}) do |context, hash|
            hash[context.model] = context
          end
        end
        memoize :mapping

        def inverse
          Polymorphic::Map::Loader.new(body.map(&:inverse))
        end

        def mapper(klass)
          mapping.fetch(klass)
        end

        class Result < NAry::Result
          def process
            mapper = context.mapper(input.class)
            result = mapper.run(input)
            unless result.successful?
              return NAry::MemberError.new(context, input, result)
            end
            result.output
          end
        end
      end
    end
  end
end
