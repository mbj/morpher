class Ducktrap
  # Mixin for defining unary ducktraps
  module Unary 
    # Instance methods mixin for unary ducktrap
    module InstanceMethods

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

      # Return result for input
      #
      # @param [Object] input
      #
      # @return [Result]
      #
      # @api private
      #
      def run(input)
        result_klass.new(self, input)
      end

      # Return inverse
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def inverse
        self.class.new(operand.inverse)
      end

      # Return ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      attr_reader :operand

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
        postprocessor = Noop.instance
        if block
          postprocessor = Ducktrap::Block.build(&block)
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

    class Result < Ducktrap::Result

      # Return operand
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def operand
        context.operand
      end

    end
  end
end
