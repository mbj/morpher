module Morpher
  class Evaluator
    class Transformer < self

      # Custom transformer
      class Custom < self
        include Nullary::Parameterized, Transitive

        register :custom

        # Call evaluator
        #
        # @param [Object] input
        #
        # @return [Object]
        #   if custom transformation was successful
        #
        # @raise [TransformError]
        #   otherwise
        #
        # @api private
        #
        def call(input)
          invoke(input)
        end

        # Return evaluation
        #
        # @param [Object] input
        #
        # @return [Evaluation]
        #
        # @api private
        #
        def evaluation(input)
          evaluation_success(input, invoke(input))
        rescue TransformError
          evaluation_error(input)
        end

        # Return inverse evaluator with reversed +params+
        #
        # @return [self]
        #
        # @api private
        #
        def inverse
          self.class.new(param.reverse)
        end

        private

        # Invoke the transformation
        #
        # @param [Object] input
        #
        # @return [Object]
        #
        # @api private
        #
        def invoke(input)
          param.first.call(input)
        end
      end # Custom
    end # Transformer
  end # Evaluator
end # Morpher
