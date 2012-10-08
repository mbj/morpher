class Transformator

  # Transformator to anima objects
  class Anima < self

    class AnimaError < Error::Wrapper; end

    register :anima

    # Builder for anima transformator
    class Builder 

      # Return model
      #
      # @return [Class]
      #
      # @api private
      #
      attr_reader :model

      # Run transformator
      #
      # @return [Transformator::Anima]
      #
      # @api private
      #
      def run(input)
        Anima.run(input, model)
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

    # Return anima model
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
      @model = model
      super(input)
    end

    # Load object
    #
    # @return [Object]
    #   if object could be loaded
    #
    # @return [Undefined]
    #   otherwise
    #
    # @api private
    #
    def load
      model.new(input)
    rescue ::Anima::AttributeError => exception
      add_exception(AnimaError, exception)
      Undefined
    end
  end
end
