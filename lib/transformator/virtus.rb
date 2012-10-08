require 'anima'

class Transformator
  # Transformator to virtus objects
  #
  # TODO: 
  #
  #  * Find catch and wrap data dependend exceptions
  #
  class Virtus < self
    # Return virtus model
    #
    # @return [Class]
    #
    # @api private
    #
    attr_reader :model

  private

    # Initialize object
    #
    # @param [Object] input
    # @param [Class] model
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(input, model)
      super(input)
      @model = model
    end

    # Load object
    #
    # @return [Object]
    #
    # @api private
    #
    def load
      model.new(input)
    end
  end
end
