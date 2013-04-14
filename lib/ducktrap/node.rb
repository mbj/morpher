module Ducktrap
  # Abstract base class for transformation nodes
  class Node
    include AbstractType, PrettyDump, Adamantium::Flat

    # Return inversed ducktrap
    #
    # @param [Object] input
    #
    # @return [Evaluator]
    #
    # @api private
    #
    abstract_method :inverse

    # Run ducktrap on input
    #
    # @param [Object] input
    #
    # @return [Evaluator]
    #
    # @api private
    #
    def run(input)
      evaluator_klass.new(self, input)
    end

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
      evaluator = run(input)
      evaluator.assert_successful
      evaluator.output
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

    # Return evaluator class
    #
    # @return [Class:Evaluator]
    #
    # @api private
    #
    def evaluator_klass
      self.class::Evaluator
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
