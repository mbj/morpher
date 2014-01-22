# encoding: UTF-8

module Morpher

  class Evaluator

    # Mixin for binary evaluators
    module Binary
      CONCORD = Concord::Public.new(:left, :right)

      PRINTER = lambda do |_|
        name
        indent do
          visit(:left)
          visit(:right)
        end
      end

      # Return node
      #
      # @return [Morpher::Node]
      #
      # @api private
      #
      def node
        s(type, left.node, right.node)
      end

    private

      # Methods mixed in into class level
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
          Compiler.assert_child_nodes(node, 2)
          left, right = *node
          new(compiler.call(left), compiler.call(right))
        end

      end # ClassMethods

      # Hook called when module gets included
      #
      # @return [undefined]
      #
      # @api private
      #
      def self.included(descendant)
        descendant.class_eval do
          include CONCORD
          extend ClassMethods
          printer(&PRINTER)
        end
      end
      private_class_method :included

    end # Nary

  end # Evaluator
end # Morpher
