class Ducktrap
  class Static < self
    include Nullary, Concord.new(:value, :inverse_value)

    register :static

    # Run ducktrap on input
    #
    # @param [Object] input
    #
    # @return [Result]
    #
    # @api private
    #
    def run(input)
      Result::Static.new(self, input, value)
    end

    # Return inverse ducktrap
    #
    # @return [Ducktrap]
    #
    # @api private
    #
    def inverse
      Static.new(inverse_value, value)
    end
  end
end
