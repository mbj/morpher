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
