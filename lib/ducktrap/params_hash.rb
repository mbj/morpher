class Ducktrap
  # Abstract base class for ducktraps that result in params hash
  class ParamsHash < self

    class AttributeHashExtraction < self
      include NAry

      register :params_hash_from_attribute_hash_extraction

      def inverse
        Ducktrap::AttributeHash::ParamsHashExtraction.new(inverse_body)
      end

      class Result < NAry::Result
        def process
          body.each_with_object({}) do |controller, hash|
            name = controller.name
            value = NamedValue.new(name, input.fetch(name))
            result = controller.run(value)

            unless result.successful?
              return NAry::MemberError.new(context, input, result)
            end

            hash.merge!(result.output)
          end
        end
      end
    end

    class Attribute < self
      include Unary
      include Equalizer.new(:name, :postprocessor)

      register :params_hash_from_attribute

      attr_reader :name
      attr_reader :postprocessor

      def initialize(name, postprocessor = Noop.instance)
        @name, @postprocessor = name, postprocessor
      end

      def inverse
        Ducktrap::Attribute::ParamsHash.new(name, postprocessor.inverse)
      end

      def pretty_dump(output=Formatter.new)
        output.puts(self.class.name)
        output = output.indent
        output.puts("name: #{name.inspect}")
        output.puts('postprocessor:')
        postprocessor.pretty_dump(output.indent)
      end

      def self.build(name, &block)
        postprocessor = Noop.instance

        if block
          postprocessor = Ducktrap::Block.build(&block)
        end

        new(name, postprocessor)
      end

      class Result < Ducktrap::Unary::Result

        def name
          context.name
        end

        def postprocessor
          context.postprocessor
        end

        def process
          value = input.value
          result = postprocessor.run(value)

          unless result.successful?
            return NAry::MemberError.new(context, input, result)
          end

          { name.to_s => result.output }
        end
      end
    end
  end
end
