module Morpher
  class Evaluator
    class Transformer

      # Too complex hash transformation evaluator
      #
      # FIXME: Shold be broken up in better primitives
      #
      # @api private
      #
      class HashTransform < self
        include Concord.new(:body)

        register :hash_transform

        def call(input)
          content = body.map do |node|
            node.call(input)
          end
          Hash[content]
        end

        def inverse
          inverse_body = body.map do |evaluator|
            evaluator.inverse
          end

          self.class.new(inverse_body)
        end

        def evaluation(input)
          evaluations = body.map do |evaluator|
            evaluator.evaluation(input)
          end

          output = Hash[evaluations.map(&:output)]

          Evaluation::Nary.new(
            :evaluator   => self,
            :input       => input,
            :evaluations => evaluations,
            :output      => output
          )
        end

        def self.build(compiler, node)
          body = node.children.map do |node|
            compiler.call(node)
          end
          new(body)
        end

      end # HashTransform
    end # Transformer
  end # Evaluator
end # Morpher
