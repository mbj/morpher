class Ducktrap

  # Abstract base class for ducktraps that result in attribute hash
  class AttributesHash < self
    class Anima < self
      register :attributes_hash_from_anima

      def run(input)
        Result::Static.new(self, input, model.attributes_hash(input))
      end

      def inverse
        Ducktrap::Anima::AttributesHash.new(model)
      end

      def self.build(model)
        new(model)
      end

      attr_reader :model

      def initialize(model)
        @model = model
      end
    end

    class ParamsHashExtraction < self
      include Nary

      register :attributes_hash_from_params_hash_extraction

      def inverse
        Ducktrap::ParamsHash::AttributesHashExtraction.new(inverse_body)
      end

      class Result < Nary::Result
        def process
          results.each_with_object({}) do |result, hash|
            output = result.output
            unless result.successful?
              return Nary::MemberError.new(context, input, result)
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
  end
end
