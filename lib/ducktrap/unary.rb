class Ducktrap
  # Abstract ducktrap that delegates a single ducktrap
  module Unary 

    module InstanceMethods
      def run(input)
        result_klass.new(self, input, operand)
      end

      # Return ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      attr_reader :operand

      def pretty_dump(output)
        output.puts(self.class.name)
        output = output.indent
        output.puts("operand:")
        operand.pretty_dump(output.indent)
      end

    private

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
    end

    module ClassMethods
      def build(*args, &block)
        postprocessor = Noop.instance

        if block
          postprocessor = Ducktrap::Block.build(&block)
        end

        new(postprocessor, *args)
      end
    end

    def self.included(scope)
      scope.send(:include, InstanceMethods)
      scope.extend(ClassMethods)
    end

    class Result < Ducktrap::Result
      attr_reader :operand

      def initialize(context, input, operand)
        @operand = operand
        super(context, input)
      end
    end
  end
end
