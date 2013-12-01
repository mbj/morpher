module Morpher
  class Evaluator
    class Transformer

      # Too complex hash transformation evaluator
      #
      # FIXME: Shold be broken up in better primitives a decompose, compose pair
      #
      # @api private
      #
      class HashTransform < self
        include Concord.new(:body)

        register :hash_transform

        # Call evaluator
        #
        # @param [Object] input
        #
        # @return [Object]
        #
        # @api private
        #
        def call(input)
          content = body.map do |node|
            node.call(input)
          end
          Hash[content]
        end

        # Return inverse evaluator
        #
        # @return [HashTransform]
        #
        # @api private
        #
        def inverse
          inverse_body = body.map do |evaluator|
            evaluator.inverse
          end

          self.class.new(inverse_body)
        end

        # Return evaluation
        #
        # @param [Input]
        #
        # @return [Evaluation::Nary]
        #
        # @api private
        #
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

        # Build evaluator from node
        #
        # @param [Compiler] compiler
        # @param [Node] node
        #
        # @return [Evaluator]
        #
        # @api private
        #
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
