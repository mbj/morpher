module Morpher

  # Type lookup via registry and superclass chaining
  #
  # TODO: Cache results.
  #
  class TypeLookup
    include Adamantium::Flat, Concord.new(:registry, :exception)

    # Perform type lookup
    #
    # @param [Object] object
    #
    # @return [Object]
    #   if found
    #
    # @raise [Exception]
    #   otherwise
    #
    def call(object)
      current = target = object.class
      while current != Object
        if registry.key?(current)
          return registry.fetch(current)
        end
        current = current.superclass
      end

      raise exception.new(target)
    end

  end # TypeLookup
end # Morpher
