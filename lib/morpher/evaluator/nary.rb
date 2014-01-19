# encoding: UTF-8

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

    private

      # Return positive evaluation
      #
      # @param [Object] input
      # @param [Array<Evaluation>] evaluations
      #
      # @return [Evaluation]
      #
      # @api private
      #
      def evaluation_positive(input, evaluations)
        Evaluation::Nary.success(
          evaluator:   self,
          input:       input,
          output:      true,
          evaluations: evaluations
        )
      end

      # Return negative evaluation
      #
      # @param [Object] input
      # @param [Array<Evaluation>] evaluations
      #
      # @return [Evaluation]
      #
      # @api private
      #
      def evaluation_negative(input, evaluations)
        Evaluation::Nary.success(
          evaluator:   self,
          input:       input,
          output:      false,
          evaluations: evaluations
        )
      end

      # Return evaluation error
      #
      # @param [Object] input
      # @param [Array<Evaluation>] evaluations
      #
      # @return [Evaluation]
      #
      # @api private
      #
      def evaluation_error(input, evaluations)
        Evaluation::Nary.error(
          evaluator:   self,
          input:       input,
          evaluations: evaluations
        )
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
