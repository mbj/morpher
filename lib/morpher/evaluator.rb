module Morpher

  # Abstract namespace class for non tracking evaluators
  class Evaluator
    include AbstractType, Printer::Mixin, Adamantium::Flat

    # Register evaluator under name
    #
    # TODO: Disallow duplicate registration under same name
    #
    # @param [Symbol] name
    #
    # @return [undefined]
    #
    # @api private
    #
    def self.register(name)
      REGISTRY[name] = self
    end
    private_class_method :register

    # Call evaluator in non tracking mode
    #
    # @param [Object] input
    #
    # @return [Object]
    #
    # @api private
    #
    abstract_method :call

    # Call evaluator in tracking mode
    #
    # @param [Object] input
    #
    # @return [Evaluation]
    #
    # @api private
    #
    abstract_method :evaluation

    # Return inverse evaluator
    #
    # @return [Evaluator]
    #
    # @api private
    #
    abstract_method :inverse

  end # Evaluator
end # Morpher
