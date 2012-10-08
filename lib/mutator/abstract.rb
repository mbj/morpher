class Mutator

  # Namespace for non root abstract mutators
  module Abstract

    # Abstract mutator that only acts on input
    class Input < Mutator
      include AbstractClass

      # Run mutator on input
      #
      # @param [Object] input
      #
      # @return [Result]
      #
      # @api private
      #
      def self.run(input)
        self::RESULT.new(input)
      end

      # Return mutator
      #
      # @return [self]
      #
      # @api private
      #
      def self.new
        self
      end

    end

    # Abstract mutator that delegates to n other mutators
    class NAry < Mutator
      include AbstractClass, Equalizer.new(:body)

      # Run mutator on input
      #
      # @param [Object] input
      #
      # @return [Result]
      #
      # @api private
      #
      def run(input)
        result_klass.new(input, body)
      end

      # Add primitive enforcement
      #
      # @return [self]
      #
      # @api private
      #
      def primitive(primitive)
        add(Primitive.new(primitive))
      end

      # Return result class
      #
      # @return [Class:Result]
      #
      # @api private
      #
      def result_klass
        self.class::RESULT
      end

      # Add mutator argument
      #
      # @param [Mutator] mutator
      #
      # @return [self]
      #
      def add(mutator)
        body << mutator
        self
      end

      # Return body 
      #
      # @return [Enumerable<Mutator>]
      #
      # @api private
      #
      attr_reader :body

    private

      # Initialize object
      #
      # @param [Enumerable<Mutator>] body
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(body=[])
        @body = body
        super()
      end

      # Hook called when method is missing
      #
      # @return [Object]
      #
      # @api private
      #
      def method_missing(name, *arguments, &block)
        builder = DSL.lookup(name) { super }
        add(builder.new(*arguments, &block))
      end
    end
  end
end
