module Morpher
  class Evaluator
    class Transformer

      # Transformer that allows to guard transformation process with a predicate on input
      class Guard < self
        include Concord::Public.new(:predicate), Transitive

        register :guard

        printer do
          name
          visit(:predicate)
        end

        # Call evaluator
        #
        # @parma [Object] input
        #
        # @return [Object]
        #   if input evaluates true under predicate
        #
        # @raise [TransformError]
        #   otherwise
        #
        # @api private
        #
        def call(input)
          if predicate.call(input)
            input
          else
            raise TransformError.new(self, input)
          end
        end

        # Return evaluation
        #
        # @param [Object] input
        #
        # @return [Evaluation::Guard]
        #
        # @api private
        #
        def evaluation(input)
          Evaluation::Guard.new(
            input:     input,
            output:    input,
            evaluator: self,
            predicate: predicate.call(input)
          )
        end

        # Return inverse evaluator
        #
        # @return [self]
        #
        # @api private
        #
        def inverse
          self
        end

        # Build evaluator from node
        #
        # @param [Compiler] compiler
        # @param [Node] node
        #
        # @api private
        #
        # @return [Evaluator  ]
        #
        def self.build(compiler, node)
          new(compiler.call(node.children.first))
        end

      end # Guard
    end # Transformer
  end # Evaluator
end # Morpher
