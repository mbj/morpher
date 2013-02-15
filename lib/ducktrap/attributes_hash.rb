class Ducktrap

  # Abstract base class for ducktraps that result in attribute hash
  class AttributesHash < self

    register :attributes_hash

    class ParamsHashExtraction < self
      include Nary

      register :attributes_hash_from_params_hash_extraction

      # Return inverse ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def inverse
        Ducktrap::ParamsHash::AttributesHashExtraction.new(inverse_body)
      end

      class Result < Nary::Result

      private

        # Process input
        #
        # @return [undefined]
        #
        # @api private
        #
        def process
          results.each_with_object({}) do |result, hash|
            unless result.successful?
              return nested_error(result)
            end

            output = result.output

            hash[output.name]=output.value
          end
        end

        # Enumerate results
        #
        # @return [self]
        #   if block given
        #
        # @return [Enumerable<Object>]
        #   otherwise
        #
        # @api private
        #
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
