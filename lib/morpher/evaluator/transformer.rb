module Morpher
  class Evaluator
    # Abstract namespace class for transforming evaluators
    class Transformer < self
      include AbstractType

      # Error raised when transformation cannot continue
      class TransformError < RuntimeError
        include Concord.new(:transformer, :input)
      end

    private

      # Raise transform error
      #
      # @param [Object] input
      #
      # @raise [TransformError]
      #
      # @api private
      #
      def raise_transform_error(input)
        raise TransformError.new(self, input)
      end

    end # Transform
  end # Evaluator
end # Morpher
