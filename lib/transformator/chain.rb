class Transformator

  # Chain of transformators that returns the last result and stops on first unsuccessful transformatorion.
  #
  # TODO: Rename to Block
  #
  class Chain < self

    # Return transformators
    #
    # @return [Enumerable<Transformator>]
    #
    # @api private
    #
    attr_reader :transformators

    # Builder for chain transformator
    class Builder < Transformator::Builder

      # Add transformator
      #
      # @param [Transformator]
      #
      # @api private
      #
      def add(transformator)
        @transformators << transformator
      end

      # Run transformator
      #
      # @param [Input]
      #
      # @api private
      #
      def run(input)
        Chain.new(input, transformators)
      end

      # Return transformators
      #
      # @return [Enumerable<Transformator>]
      #
      # @api private
      #
      attr_reader :transformators

    private

      # Initialize builder
      #
      # @api private
      #
      # @return [undefined]
      #
      def initialize(transformators=[])
        @transformators = transformators
        super()
      end
    end

  private

    # Load input
    #
    # @return [Object]
    #   when all transformators are successful returns the last result
    #
    # @return [Undefined]
    #   otherwise
    #
    # @api private
    #
    def load
      transformators.inject(input) do |input, transformator|
        transformator = transformator.run(input)

        if transformator.successful?
          transformator.result
        else
          add_errors(transformator.errors)
          return Undefined
        end
      end
    end

    # Initialize object
    #
    # @param [Object] input
    # @param [Enumerable<Transformator>] transformators
    #
    def initialize(input, transformators)
      @transformators = transformators
      super(input)
    end

  end
end
