class Transformator

  # Abstract base class for transformator builders
  class Builder
    include AbstractClass, Immutable

    # Mixin to define noop builder on transformator
    module Noop 

      # Return transformator
      #
      # @return [self]
      #
      # @api private
      #
      def build
        raise if block_given?
        self
      end
    end

    # Enforce primitives
    #
    # @return [self]
    #
    # @api private
    #
    def primitive(*primitives)
      transformators = primitives.map do |primitive|
        Primitive.build(primitive)
      end

      add(Chain.build(transformators))
    end

    # Registry for dsl methods and names
    class Registry

      # Null registry 
      module Null

        # Return transformator for name
        #
        # @return [self]
        #
        # @api private
        #
        def self.lookup(name)
          yield
          self
        end

      end

      # Add transformator under name
      #
      # @param [Symbol] name
      # @param [Transformator] transformator
      #
      # @return [self]
      #
      # @api private
      #
      def add(name, transformator)
        @index[name] = transformator
        self
      end

      # Lookup transformator for name
      #
      # @param [Symbol] name
      #
      # @return [Transformator]
      #   if found
      #
      # @return [self]
      #   otherwise
      #
      # @yield 
      #   if no transformator found for name
      #
      # @api private
      #
      def lookup(name, &block)
        @index.fetch(name) do
          @parent.lookup(name, &block)
        end
      end

      # Build registry for class
      #
      # @param [Class] klass
      #
      # @return [Registry]
      #
      # @api private
      #
      def self.build(klass)
        superclass = klass.superclass

        registry =
          if superclass.respond_to?(:registry)
            superclass.registry
          else
            Null
          end

        new(registry)
      end

    private

      # Initialize object
      #
      # @param [#lookup] parent
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(parent)
        @parent = parent
        @index = {}
      end
    end

    # Register transformator under name
    #
    # @param [Symbol] name
    # @param [Transformator] transformator
    #
    # @return [self]
    #
    # @api private
    #
    def self.register(name, transformator)
      registry.add(name, transformator)
      self
    end

    # Return registry
    #
    # @return [Hash]
    #
    # @api private
    #
    def self.registry
      @registry ||= Registry.build(self)
    end

    # Add transformator to builder
    #
    # @param [Transformator]
    #
    # @api private
    #
    abstract_method :add

    # Run transformator 
    #
    # @return [Transformator]
    #
    # @api private
    #
    abstract_method :run

  private

    # Initialize object
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(&block)
      instance_eval(&block) if block
    end

    # Hook called when method is missing
    #
    # @return [Object]
    #
    # @api private
    #
    def method_missing(name, *arguments, &block)
      transformator = self.class.registry.lookup(name) do
        super
      end

      add(transformator.build(*arguments, &block))
    end
  end
end
