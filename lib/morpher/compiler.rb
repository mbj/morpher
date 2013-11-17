module Morpher

  # Abstract base class for compilers
  class Compiler
    include AbstractType, Concord.new(:registry)

    abstract_method :call

  private

    def lookup(node)
      registry.fetch(node.type)
    end

    # Compiler plain evaluators
    class Evaluating < self

      def call(node)
        lookup(node).build(self, node)
      end

    end # Evaluating

  end # Compiler
end # Morpher
