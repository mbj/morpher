class Ducktrap
  class Noop < self
    include Singleton

    # Run ducktrap
    #
    # @param [Object] input
    # 
    # @return [Result]
    #
    # @api private
    #
    def run(input)
      Result::Static.new(self, input, input)
    end

    # Return inverse ducktrap
    #
    # @return [Ducktrap]
    #
    # @api private
    #
    def inverse; self; end
  end
end
