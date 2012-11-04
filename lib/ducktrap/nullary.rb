class Ducktrap
  # Mixin to define nullary ducktraps
  module Nullary 
    module InstanceMethods
      include Adamantium::Flat
      # Run ducktrap on input
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

      # Return inspect string
      #
      # @return [String]
      #
      def inspect
        self.class.name
      end
      memoize :inspect
    end

    module ClassMethods
      # Return ducktrap
      #
      # @return [self]
      #
      # @api private
      #
      def new
        @instance ||= super
      end
    end

    def self.included(scope)
      scope.extend(ClassMethods)
      scope.send(:include,InstanceMethods)
    end

    # Mixin to define nullary results
    module Result
    end
  end
end
