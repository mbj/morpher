module Morpher

  # Abstract namespace class for non tracking evaluators
  class Evaluator
    include Adamantium::Flat, Registry, AbstractType, Printer::Mixin

    # Mixin for evaluators that are transitive by definition
    module Transitive

      # Test if evaluator is transitive
      #
      # @return [false]
      #
      # @api private
      #
      def transitive?
        true
      end

    end # Intransitive

    # Mixin for evaluators that are intransitive by definition
    module Intransitive

      # Test if evaluator is transitive
      #
      # @return [false]
      #
      # @api private
      #
      def transitive?
        false
      end

    end # Intransitive

    # Call evaluator in non tracking mode
    #
    # @param [Object] input
    #
    # @return [Object]
    #
    # @api private
    #
    abstract_method :call

    # Test evaluator transformer is transitive
    #
    # A transitive evaluator allows to inverse an operation via its #inverse evaluator.
    #
    # @return [true]
    #   if transformer is transitive
    #
    # @return [false]
    #   otherwise
    #
    # @api private
    #
    abstract_method :transitive?

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
