# Library namespace and abstract base class for mutators
class Mutator

  # Registry for mutators
  class Registry

    # Register mutator under name
    #
    # @param [Symbol] name
    # @param [Mutator] mutator
    #
    # @return [self]
    #
    # @api private
    #
    def register(name, mutator)
      @index[name] = mutator

      self
    end

    # Lookup mutator for name
    #
    # @param [Symbol] name
    #
    # @return [Mutator]
    #   if found
    #
    # @return [self]
    #   otherwise
    #
    # @yield 
    #   if no mutator found for name
    #
    # @api private
    #
    def lookup(name, &block)
      @index.fetch(name) do
        yield
      end
    end

  private

    # Initialize object
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize
      @index = {}
    end
  end

  DSL = Registry.new
end
