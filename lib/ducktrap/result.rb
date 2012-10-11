class Ducktrap

  # Abstract base class for mutation result
  class Result
    include AbstractClass, Immutable

    # Include equalizer
    #
    # @return [self]
    #
    def self.equalize(*extra)
      include Equalizer.new(:input, :output, *extra)
    end
    private_class_method :equalize

    # Undefined result
    module Undefined; freeze; end

    # Test if load was successful
    #
    # @return [true]
    #   if loading was successful
    #
    # @return [false]
    #   otherwise
    #
    # @api private
    #
    def successful?
      output != Undefined
    end

    # Return input
    #
    # @return [Object]
    #
    # @api private
    #
    attr_reader :input

    # Return result
    #
    # @return [Object]
    #
    # @api private
    #
    def output
      result
    end
    memoize :output

  private

    # Initialize object
    #
    # @param [Object] input
    #   the input to dload
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(input)
      @input  = input
      # Trigger load
      output
    end

    # Calculate result
    #
    # @return [Object]
    #   if successful
    #
    # @return [Undefined]
    #   otherwise
    #  
    # @api private
    #
    abstract_method :result
    private :result

  end
end
