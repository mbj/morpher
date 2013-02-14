class Ducktrap
  # Abstract base class for ducktraps that result in params hash
  class ParamsHash < self

    # Attribute hash extraction
    class AttributesHashExtraction < self
      include Nary

      register :params_hash_from_attributes_hash_extraction

      # Retuirn inverse
      #
      # @return [Ducktrap] 
      #
      # @api private
      #
      def inverse
        Ducktrap::AttributesHash::ParamsHashExtraction.new(inverse_body)
      end

      # Result of attribute hash extraction
      class Result < Nary::Result

      private

        # Calcluate result
        #
        # @return [Object]
        #
        # @api private
        #
        def process
          body.each_with_object({}) do |controller, hash|
            name = controller.name
            value = NamedValue.new(name, input.fetch(name))
            result = controller.run(value)

            unless result.successful?
              return nested_error(result)
            end

            hash.merge!(result.output)
          end
        end
      end
    end

    class Attribute < self
      include Unary, Composition.new(:name, :postprocessor)

      register :params_hash_from_attribute

      # Return inverse ducktrap
      #
      # @return [Duckrap]
      #
      # @api private
      #
      def inverse
        Ducktrap::Attribute::ParamsHash.new(name, postprocessor.inverse)
      end

      # build attribute hash extraction
      #
      # @param [Symbol] name
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def self.build(name, &block)
        postprocessor = Noop.instance

        if block
          postprocessor = Ducktrap::Block.build(&block)
        end

        new(name, postprocessor)
      end

    private

      # Dump object
      #
      # @param [Formatter] output
      #
      # @return [undefined]
      #
      # @api private
      #
      def dump(output)
        output.name(self)
        output = output.indent
        output.puts("name: #{name.inspect}")
        output.nest('postprocessor:', postprocessor)
      end

      # Result of attribute
      class Result < Ducktrap::Unary::Result

      private

        # Return key
        #
        # @return [String]
        #
        # @api private
        #
        def key
          context.name.to_s
        end

        # Return postprocessor
        #
        # @return  [Ducktrap]
        #
        # @api private
        #
        def postprocessor
          context.postprocessor
        end

        # Return result
        #
        # @return [Object]
        #
        # @api private
        #
        def process
          value = input.value
          result = postprocessor.run(value)

          unless result.successful?
            return nested_error(result)
          end

          { key => result.output }
        end
      end
    end
  end
end
