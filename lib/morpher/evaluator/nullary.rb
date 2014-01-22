# encoding: UTF-8

module Morpher
  class Evaluator
    # Mixin to define nullary evaluators
    module Nullary

      CONCORD = Concord::Public.new

      PRINTER = lambda do |_|
        name
      end

      # Return default successful evaluation
      #
      # @param [Object] input
      #
      # @return [Evaluation]
      #
      # @api private
      #
      def evaluation(input)
        evaluation_success(input, call(input))
      end

      # Return node
      #
      # @return [Morpher::Node]
      #
      # @api private
      #
      def node
        s(type)
      end

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

      module ClassMethods

        # Build nary nodes
        #
        # @param [Compiler] _compiler
        # @param [Morpher::Node] node
        #
        # @return [Evaluator::Nary]
        #
        # @api private
        #
        def build(_compiler, node)
          Compiler.assert_child_nodes(node, 0)
          new
        end

      end # ClassMethods

    private

      # Return evaluation error for input
      #
      # @param [Object] input
      #
      # @return [Evaluation]
      #
      # @api private
      #
      def evaluation_error(input)
        Evaluation::Nullary.new(
          evaluator: self,
          input:     input,
          output:    Undefined,
          success:   false
        )
      end

      # Return evaluation success for input and output
      #
      # @param [Object] input
      # @param [Object] output
      #
      # @return [Evaluation]
      #
      # @api private
      #
      def evaluation_success(input, output)
        Evaluation::Nullary.new(
          evaluator: self,
          input:     input,
          output:    output,
          success:   true
        )
      end

    end # Nullary
  end # Evaluator
end # Morpher
