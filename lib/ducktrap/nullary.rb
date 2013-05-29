module Ducktrap
  # Mixin for defining nullary ducktraps
  module Nullary 
    # Class method mixin
    module ClassMethods

      # Build ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def build(*args)
        if block_given?
          raise "#{name}.build does not take a block"
        end
        new(*args)
      end

    end # ClassMethods

    # Hook called when module is included
    #
    # @param [Module] scope
    #
    # @return [undefined]
    #
    # @api private
    #
    def self.included(scope)
      scope.extend(ClassMethods)
    end
    private_class_method :included

    # Evaluator for nullary nodes
    class Evaluator < Ducktrap::Evaluator

    end # Evaluator

  end # nullary
end # Ducktrap
