module Morpher
  class Evaluator
    class Transformer

      # Transformer that allows to guard transformation process with a predicate on input
      class Guard < self
        include Concord.new(:predicate)

        register :guard

        def call(input)
          if predicate.call(input)
            input
          else
            raise TransformError.new(self, input)
          end
        end

        def evaluation(input)
          Evaluation::Guard.new(
            :input     => input,
            :output    => input,
            :evaluator => self,
            :predicate => predicate.call(input)
          )
        end

        def inverse
          self
        end

        def self.build(compiler, node)
          new(compiler.call(node.children.first))
        end

      end # Guard
    end # Transformer
  end # Evaluator
end # Morpher
