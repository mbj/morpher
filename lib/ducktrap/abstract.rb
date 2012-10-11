class Ducktrap

  # Namespace for non root abstract ducktraps
  module Abstract

    # Abstract ducktrap that only acts on input
    class Nullary < Ducktrap
      include AbstractClass

      # Run ducktrap on input
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

      # Return ducktrap
      #
      # @return [self]
      #
      # @api private
      #
      def self.new
        self
      end

    end

    # Abstract ducktrap that delegates to two other ducktraps
    class Unary < Ducktrap
      include AbstractClass, Equalizer.new(:ducktrap)

      # Run ducktrap on input
      #
      # @param [Object] input
      #
      # @return [Result]
      # 
      # @api private
      #
      def run(input)
        result_klass.new(input, ducktrap)
      end

      # Return ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      attr_reader :ducktrap

    private

      # Initialize object
      #
      # @param [Ducktrap] ducktrap
      #
      # @api private
      #
      def initialize(ducktrap)
        @ducktrap = ducktrap
      end

    end

    # Abstract ducktrap that delegates to two other ducktraps
    class Binary < Ducktrap
      include AbstractClass, Equalizer.new(:left, :right)

      # Run ducktrap on input
      #
      # @param [Object] input
      #
      # @return [Result]
      # 
      # @api private
      #
      def run(input)
        result_klass.new(input, left, right)
      end

      # Return right ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      attr_reader :right

      # Return left ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      attr_reader :left

    private

      # initialize ducktrap
      #
      # @param [Ducktrap] left
      # @param [Ducktrap] right
      #
      def initialize(left, right)
        @left, @right = left, right
      end
    end

    # Abstract ducktrap that delegates to n other ducktraps
    class NAry < Ducktrap
      include AbstractClass, Equalizer.new(:body)

      # Run ducktrap on input
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

      # Add ducktrap argument
      #
      # @param [Ducktrap] ducktrap
      #
      # @return [self]
      #
      def add(ducktrap)
        body << ducktrap
        self
      end

      # Return body 
      #
      # @return [Enumerable<Ducktrap>]
      #
      # @api private
      #
      attr_reader :body

    private

      # Initialize object
      #
      # @param [Enumerable<Ducktrap>] body
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
