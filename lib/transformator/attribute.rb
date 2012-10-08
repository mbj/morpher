class Transformator

  # Abstract transformator to single attribute
  class Attribute < self
    include AbstractClass

    class Builder < Transformator::Builder

      # Run transformator on input
      #
      # @param [Object] input
      #
      # @return [Transformator]
      #
      # @api private
      #
      def run(input)
        @transformator.run(input, @name)
      end

    private

      # Initialize object
      #
      # @param [Symbol] name
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(transformator, name, &block)
        @name = name
        @transformator = Chain::Builder.new([transformator], &block)
      end

    end

    # Run builder
    #
    # @return [Builder]
    #
    # @api private
    #
    def self.build(*arguments, &block)
      self::Builder.new(self, *arguments, &block)
    end

    # Return name
    #
    # @return [Symbol]
    #
    # @api private
    #
    attr_reader :name

  private

    # Initialize object
    #
    # @param [Symbol] name
    # @param [Transformator] transformator
    #
    def initialize(input, name)
      @name = name
      super(input)
    end
  end
end
