class Ducktrap
  class AttributeCollection < self
    class AttributeHash < self
      register :attribue_collection_form_attribute_hash
      include Nullary

      def run(input)
        input.values
      end

      def inverse; AttributeHash::AttributeSet; end
    end

    class ParamsHash < self
      include NAry

      register :attribute_collection_from_params_hash

      def inverse; ParamsHash::AttributeCollection; end

      class Result < NAry::Result

      private

        def process
          unless results.all?(&:successful?)
            return error
          end

          results.map(&:output)
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
