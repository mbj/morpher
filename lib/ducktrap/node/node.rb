module Ducktrap
  # Abstract base class for transformation nodes
  class Node

    # Return inversed ducktrap
    #
    # @param [Object] input
    #
    # @return [Result]
    #
    # @api private
    #
    abstract_method :inverse

    # Run ducktrap on input
    #
    # @param [Object] input
    #
    # @return [Result]
    #
    # @api private
    #
    abstract_method :run

    # Process input and raise exception on error
    #
    # @param [Object] input
    #
    # @return [Object]
    #   if successful
    #
    # @raise [RuntimeError]
    #   otherwise
    #
    # @api private
    #
    def call(input)
      result = run(input)
      result.assert_successful
      result.output
    end

    # Register dsl name
    #
    # @param [Symbol] name
    #
    # @return [self]
    #
    # @api private
    #
    def self.register(name)
      DSL.register(name, self)
    end
    private_class_method :register

    # Return result class
    #
    # @return [Class:Result]
    #
    # @api private
    #
    def result_klass
      self.class::Result
    end

    # Build ducktrap
    #
    # @return [Ducktrap]
    #
    # @api private
    #
    def self.build(&block)
      self::Block.build(&block)
    end

  private

    # Dump object
    #
    # @param [Formatter] output
    #
    # @return [undefined]
    #
    # @api private
    #
    def dump(output)
      output.name(self)
    end

  end
end
