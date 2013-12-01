module Morpher

  class Evaluator

    # Mixin for nary evaluators
    module Nary
      CONCORD = Concord::Public.new(:body)

      PRINTER = lambda do |_|
        name
        indent do
          visit_many(:body)
        end
      end

      module ClassMethods

        # Build nary nodes
        #
        # @param [Compiler] compiler
        # @param [Morpher::Node] node
        #
        # @return [Evaluator::Nary]
        #
        # @api private
        #
        def build(compiler, node)
          body = node.children.map do |child|
            compiler.call(child)
          end
          new(body)
        end

      end # ClassMethods

      # Hook called when module gets included
      #
      # @return [self]
      #
      # @api private
      #
      def self.included(descendant)
        super
        descendant.class_eval do
          include CONCORD
          extend ClassMethods
          printer(&PRINTER)
        end
        self
      end
      private_class_method :included

    end # Nary

  end # Evaluator
end # Morpher
