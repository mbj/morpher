class Mutator

  # Mutator that results in anima objects
  class Anima < self
    include Equalizer.new(:model)

    # Return model
    #
    # @return [Class]
    #
    # @api private
    #
    attr_reader :model

    register :anima

    # Run mutator
    #
    # @return [Result::Anima]
    #
    # @api private
    #
    def run(input)
      Result::Anima.new(input, model)
    end

  private

    # Initialize object
    #
    # @param [Model] 
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(model)
      @model = model
    end
  end
end
