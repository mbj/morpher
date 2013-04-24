module Ducktrap

  # Registry for ducktraps
  class Registry

    # Register ducktrap under name
    #
    # @param [Symbol] name
    # @param [Ducktrap] ducktrap
    #
    # @return [self]
    #
    # @api private
    #
    def register(name, ducktrap)
      if @index.key?(name)
        raise "name: #{name.inspect} does already exist" 
      end

      @index[name] = ducktrap

      self
    end

    # Lookup ducktrap for name
    #
    # @param [Symbol] name
    #
    # @return [Ducktrap]
    #   if found
    #
    # @return [self]
    #   otherwise
    #
    # @yield 
    #   if no ducktrap found for name
    #
    # @api private
    #
    def lookup(name)
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
