module Morpher

  class Evaluator

    class NAry < self
      include Concord::Public.new(:evaluators)


      class Block < self
        register :block

        def call(input)
          evaluators.inject(input) do |state, evaluator|
            evaluator.call(state)
          end
        end

        def pretty_dump(printer)
          printer.name(self).indented do
            evaluators.each do |evaluator|
              printer.visit(evaluator)
            end
          end
          self
        end

        def evaluation(input)
          evaluations = []

          output = evaluators.inject(input) do |state, evaluator|
            evaluation = evaluator.evaluation(state)
            evaluations << evaluation
            evaluation.output
          end

          Evaluation::Nary.new(
            :evaluator   => self,
            :input       => input,
            :output      => output,
            :evaluations => evaluations
          )
        end

        def self.build(compiler, node)
          evaluators = node.children.map do |node|
            compiler.call(node)
          end
          new(evaluators)
        end
      end
    end # NAry
  end # Evaluato
end # Morpher
