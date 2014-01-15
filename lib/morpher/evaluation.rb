module Morpher
  # Abstract namespace class for evaluation states
  class Evaluation
    include Printer::Mixin, Adamantium::Flat, Anima.new(
      :evaluator,
      :input,
      :output,
      :success
    )

    private :success

    # Test if evaluation was successful
    #
    # @return [true]
    #   if evaluation was successful
    #
    # @return [false]
    #   otherwise
    #
    # @api private
    #
    alias_method :success?, :success
    public :success?

    printer do
      name
      indent do
        attributes :input, :output
        visit :evaluator
      end
    end

    ERROR_DEFAULTS = IceNine.deep_freeze(
      output: Undefined,
      success: false
    )

    SUCCESS_DEFAULTS = IceNine.deep_freeze(
      success: true
    )

    # Return error instance
    #
    # @param [Hash<Symbol, Object>] attributes
    #
    # @return [Evaluation]
    #
    # @api private
    #
    def self.error(attributes)
      new(ERROR_DEFAULTS.merge(attributes))
    end

    # Return successful instance
    #
    # @param [Hash<Symbol, Object>] attributes
    #
    # @return [Evaluation]
    #
    # @api private
    #
    def self.success(attributes)
      new(SUCCESS_DEFAULTS.merge(attributes))
    end

    # Evaluation state for guard evaluators
    class Guard < self
      include anima.add(:predicate).remove(:success)

      # Test if guard predicate is sucessful
      #
      # @return [true]
      #   if guard is successful
      #
      # @return [false]
      #   otherwise
      #
      # @api private
      #
      alias_method :success?, :output

      printer do
        name
        indent do
          attributes :input, :output, :predicate
          visit :evaluator
        end
      end
    end

    # Evaluation state for nary evaluators
    class Nary < self
      include anima.add(:evaluations)

      printer do
        name
        indent do
          attributes :input, :output
          attribute_class :evaluator
          visit_many :evaluations
        end
      end

    end # Evaluation

    # Evaluation state for unary evaluators
    class Unary < self
      include anima.add(:operand_output)

      printer do
        name
        indent do
          attributes :input, :output, :operand_output
          visit :evaluator
        end
      end

    end # Unary

  end # Evaluation
end # Morpher
