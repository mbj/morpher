class Ducktrap

  # Abstract base class for ducktraps that result in attribute hash
  class AttributeHash < self
    class Anima < self
      register :attribute_hash_from_anima

      def run(input)
        Result::Static.new(self, input, model.attributes(input))
      end

      def inverse
        Ducktrap::Anima::AttributeHash.new(model)
      end

      attr_reader :model

      def initialize(model)
        @model = model
      end
    end

    class ParamsHash < self
      include NAry

      register :attribute_hash_from_params_hash

      def inverse
        Ducktrap::ParamsHash::AttributeHash.new(inverse_body)
      end

      class Result < NAry::Result
        def process
          results.each_with_object({}) do |result, hash|
            output = result.output
            unless result.successful?
              return NAry::MemberError.new(context, input, result)
            end

            hash[output.name]=output.value
          end
        end

        def results
          return to_enum(__method__) unless block_given?
          body.each do |context|
            yield context.run(input)
          end
        end
      end
    end

    class AttributeCollection < self
      include Nullary
      register :attributes_hash_from_attribute_set

      def run(input)
        input.each_with_object({}) do |attribute, hash|
          name = attribute.name

          if hash.key?(name)
            return DuplicateNameError.new(name)
          end

          hash[name] = attribute.value
        end
      end
    end
  end
end
