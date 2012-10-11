class Ducktrap
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

    # Pics first successful mutation
    class Any < self
      RESULT = Result::Any
      register :any
    end

    # Multiple input XOR 
    class MultiXor < self
      RESULT = Result::MultiXOR

      register :mxor
    end

    # Ducktrap that returns last result of a chain and stops on first failure
    class Block < Abstract::NAry
      RESULT = Result::Block

      register :block
    end
  end
end
