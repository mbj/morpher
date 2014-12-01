# encoding: utf-8

module Morpher
  class Executor

    class Hybrid < self

      class TransformError < StandardError
        include Concord::Public.new(:evaluation)

        def message
          evaluation.description
        end
      end # TransformError

      def call(input)
        evaluator.call(input)
      rescue Evaluator::Transformer::TransformError
        raise(TransformError.new(evaluator.evaluation(input)))
      end
    end # Hybrid
  end # Executor
end # Morpher
