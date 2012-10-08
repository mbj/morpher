class Transformator
  # Abstract base class for string transformators
  class String < self
    include AbstractClass

  private

    # Test if input is a string
    #
    # @return [true] 
    #   if input is a string
    #
    # @return [false]
    #   otherwise
    #
    # @api private
    #
    def string?
      input.kind_of?(::String)
    end

  end
end
