# encoding: UTF-8

module Morpher

  class Evaluator

    # Mixin for unary evaluators
    module Unary
      CONCORD = Concord::Public.new(:operand)

      PRINTER = lambda do |_|
        name
        indent do
          visit(:operand)
        end
      end

      # Return node
      #
      # @return [Morpher::Node]
      #
      # @api private
      #
      def node
        s(type, operand.node)
      end

    private

      # Return success evaluation for input
      #
      # @param [Object] input
      #
      # @return [Evalation::Unary]
      #
      # @api private
      #
      def evaluation_success(input, operand_evaluation, output)
        Evaluation::Unary.success(
          evaluator:          self,
          input:              input,
          operand_evaluation: operand_evaluation,
          output:             output
        )
      end

      # Return error evaluation for input
      #
      # @param [Object] input
      #
      # @return [Evalation::Unary]
      #
      # @api private
      #
      def evaluation_error(input, operand_evaluation)
        Evaluation::Unary.error(
          evaluator:          self,
          input:              input,
          operand_evaluation: operand_evaluation
        )
      end

    private

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
          Compiler.assert_child_nodes(node, 1)
          operand = compiler.call(node.children.first)
          new(operand)
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

    end # Unary

  end # Evaluator
end # Morpher
