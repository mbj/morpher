module Morpher
  class Evaluator
    # Abstract namespace class for transforming evaluators
    class Transformer < self
      include AbstractType

      # Error raised when transformation cannot continue
      class TransformError < RuntimeError
        include Concord.new(:transformer, :input)
      end

    end # Transform
  end # Evaluator
end # Morpher
