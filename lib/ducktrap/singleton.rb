module Ducktrap
  # Mixin to define nullary ducktraps
  module Singleton 
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

      # Return inverse 
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def inverse
        inverse_klass.instance
      end

      # Return inspect string
      #
      # @return [String]
      #
      # @api private
      #
      def inspect
        "<#{self.class.name}>"
      end
      memoize :inspect
    end

    module ClassMethods

      # Return instance
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def instance
        @instance ||= new
      end

      alias_method :build, :instance
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
      scope.extend(ClassMethods)
      scope.send(:include,InstanceMethods)
      scope.send(:private_class_method,:new)
    end
  end
end
