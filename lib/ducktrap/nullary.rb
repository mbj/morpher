module Ducktrap
  # Mixin for defining nullary ducktraps
  module Nullary 
    # Instance methods mixin for unary ducktrap
    module InstanceMethods

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

    end

    module ClassMethods

      # Build ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def build(*args)
        new(*args)
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

    class Evaluator < Ducktrap::Evaluator

    private

    end
  end
end
