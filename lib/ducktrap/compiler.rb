module Ducktrap

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

    # Compiler for tracking evaluators
    class Tracking < self
      include AbstractType

      def call(node)
        self.class::TRACKER.new(lookup(node).build(inner, node))
      end

      class Root < self
        TRACKER = Tracker::Root
        def inner
          Tracking::Inner.new(registry)
        end
      end

      class Inner < self
        TRACKER = Tracker::Inner
        def inner
          self
        end
      end

    end # Tracking

  end # Compiler
end # Ducktrap
