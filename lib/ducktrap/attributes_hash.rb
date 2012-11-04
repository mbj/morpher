class Ducktrap

  # Abstract base class for ducktraps that result in attribute hash
  class AttributeHash < self
    class Anima < self
      register :attributes_hash_from_anima

      def run(input)
        Result::Static.new(input, model.attributes(input))
      end

      def inverse; Anima::AttributesHash.new(model); end

      attr_reader :model

      def initialize(model)
        @model = model
      end
    end

    class ParamsHash < self
      include NAry

      register :attributes_hash_from_params_hash

      class Result < Ducktrap::Result
        include Ducktrap::NAry::Result

      private

        def process
          unless results.all?(&:valid)
            return Undefined
          end

          attributes = results.map(&:output)

          p attributes

          attributes.each_with_object({}) do |attribute, hash|
            hash[attribute.name] = attribute.value
          end
        end

        # Return result enumerator
        #
        # @return [self]
        #   if block given
        #
        # @return [Enumerator<Result>]
        #   othewise
        #
        # @api private
        #
        def results
          body.map do |ducktrap|
            ducktrap.run(input)
          end
        end
        memoize :results
      end
    end
  end
end
