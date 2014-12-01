# encoding: utf-8

module Morpher

  class Hybrid

    class TransformError < StandardError
      include Concord::Public.new(:evaluation)

      def message
        evaluation.description
      end
    end

    include Concord.new(:evaluator)

    def self.compile(node)
      new(::Morpher.compile(node))
    end

    def call(input)
      evaluator.call(input)
    rescue Evaluator::Transformer::TransformError
      raise(TransformError.new(evaluation(input)))
    end

    def evaluation(input)
      evaluator.evaluation(input)
    end

    def inverse
      self.class.new(evaluator.inverse)
    end

    def node
      evaluator.node
    end

  end # Hybrid
end # Morpher
