class Transformator

  # Transformator to attribtues
  #
  # Attributes are typically used when initializing domain objects such like 
  # virtus, anima, active record etc. Attributes are a symbol => value hash.
  #
  class Attributes < self

    class Builder < Transformator::Builder

      # Add attribute
      #
      # @param [Transformator::Attribute] attribute
      #
      # @return [self]
      #
      # @api private
      #
      def add(attribute)
        @attributes << attribute
        self
      end

      # Run builder
      #
      # @param [Input]
      #
      # @return [Transformator]
      #
      # @api private
      #
      def run(input)
        Attributes.run(input, @attributes)
      end

    private

      # Initialize object
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize
        @attributes = []
        super
      end
    end

    register :attributes

    # Return attributes
    #
    # @return [Enumerable<Transformator::Attribute>
    #
    # @api private
    #
    def attributes
      @transformators.map do |transformator| 
        attribute = transformator.run(input) 
        add_transformator(attribute)
        attribute
      end
    end
    memoize :attributes

    # Load attributes
    #
    # @return [Hash]
    #   if successful
    #
    # @return [Undefined]
    #   otherwise
    #
    # @api private
    #
    def load
      if attributes.all?(&:successful?)
        attributes_hash
      else
        Undefined
      end
    end

    # Return attributes hash
    #
    # @return [Hash]
    #
    # @api private
    #
    def attributes_hash
      attributes.each_with_object({}) do |attribute, hash|
        hash[attribute.name] = attribute.result
      end
    end
    memoize :attributes_hash

  private

    # Initialize object
    #
    # @param [Object] input
    # @param [Enumerable<Transformator::Attribute>] transformators
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(input, transformators)
      @transformators = transformators
      super(input)
    end

    # Add transformator errors
    #
    # @param [Transformator] transformator
    #
    # @return [undefined]
    #
    # @api private
    #
    def add_transformator(transformator)
      add_errors(transformator.errors)
    end

  end
end
