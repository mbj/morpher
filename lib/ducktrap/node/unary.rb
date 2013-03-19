class Ducktrap
  class Node
    # Mixin for defining unary ducktraps
    module Unary 
      # Instance methods mixin for unary ducktrap
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

      private_class_method :included

      class Result < Ducktrap::Result

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
        # @return [Result]
        #
        # @api private
        #
        def process_operand(input)
          operand.run(input)
        end

        # Process input with operand
        #
        # @return [Result]
        #
        # @api private
        #
        def operand_result
          process_operand(input)
        end
        memoize :operand_result

        # Return operand output
        #
        # @return [Object]
        #
        # @api private
        #
        def operand_output
          operand_result.output
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
          result = operand_result
          unless result.successful?
            return nested_error(result)
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

      end
    end
  end
end
