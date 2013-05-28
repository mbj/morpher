module Ducktrap
  # Mixin for defining unary ducktraps
  module Unary 
    # Instance methods mixin for unary ducktraps
    module InstanceMethods

      # Return ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      attr_reader :operand

      # Initialize object
      #
      # @param [Ducktrap] operand
      #
      # @api private
      #
      def initialize(operand)
        @operand = operand
        super()
      end

      # Return evaluator for input
      #
      # @param [Object] input
      #
      # @return [Evaluator]
      #
      # @api private
      #
      def run(input)
        evaluator_klass.new(self, input)
      end

      # Return inverse transformation
      # 
      # @return [Node]
      #
      # @api private
      #
      def inverse
        self.class.new(operand.inverse)
      end

    private

      # Perform pretty dump
      #
      # @return [self]
      #
      # @api private
      #
      def dump(output)
        output.name(self)
        output.nest('operand:', operand)
        self
      end

    end

    module ClassMethods

      # Build ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def build(*args, &block)
        postprocessor = Node::Noop.instance
        if block
          postprocessor = Node::Block.build(&block)
        end
        new(postprocessor, *args)
      end

    end

    # Hook called when module is included
    #
    # @param [Module] scope
    #
    # @return [undefined]
    #
    # @api private
    #
    def self.included(scope)
      scope.send(:include, InstanceMethods)
      scope.extend(ClassMethods)
    end

    private_class_method :included

    # Evaluator for unary nodes
    class Evaluator < Ducktrap::Evaluator

    private

      # Return operand
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def operand
        context.operand
      end

      # Process operand
      #
      # @param [Object] input
      #
      # @return [Evaluator]
      #
      # @api private
      #
      def process_operand(input)
        operand.run(input)
      end

      # Process input with operand
      #
      # @return [Evaluator]
      #
      # @api private
      #
      def operand_evaluator
        process_operand(input)
      end
      memoize :operand_evaluator

      # Return operand output
      #
      # @return [Object]
      #
      # @api private
      #
      def operand_output
        operand_evaluator.output
      end

      # Process input
      #
      # @param [Object]
      #
      # @return [Object]
      #   if successful
      #
      # @return [Error]
      #   otherwise
      #
      # @api private
      #
      def process
        evaluator = operand_evaluator
        unless evaluator.successful?
          return nested_error(evaluator)
        end
        process_operand_output
      end

      # Process operand output
      #
      # @return [Object]
      #
      # @api private
      #
      abstract_method :process_operand_output

    end # Evaluator
  end # Unary
end # Ducktrap
