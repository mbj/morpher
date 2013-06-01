module Ducktrap
  # Mixin to define nullary ducktraps
  module Singleton 
    module InstanceMethods
      include Adamantium::Flat

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

    private

    end # InstanceMethods

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
      scope.module_eval do
        extend ClassMethods
        include InstanceMethods
        private_class_method :new
      end
    end

  end # Singleton
end # Ducktrap
