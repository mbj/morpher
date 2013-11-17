module Morpher
  # Abstract namespace class for evaluation states
  class Evaluation

    include Adamantium::Flat, Anima.new(
      :evaluator,
      :input,
      :output
    )

    # Return description
    #
    # @return [String]
    #
    # @api private
    #
    def description
      io = StringIO.new
      Printer.new(io).visit(self)
      io.rewind
      io.read
    end
    memoize :description

    def pretty_dump(printer)
      printer.name(self)
      printer.attributes(self, :input, :output)
      printer.indented do
        printer.puts 'evaluator:'
        printer.visit_indented(evaluator)
      end
      self
    end

    class Nary < self
      include anima.add(:evaluations)

      def pretty_dump(printer)
        printer.name(self)
        printer.indented do
          printer.puts "evaluator: #{evaluator.class}"
        end
        printer.attributes(self, :input, :output)
        printer.indented do
          printer.puts 'evaluations:'
          evaluations.each do |evaluation|
            printer.visit_indented(evaluation)
          end
        end
        self
      end


    end # Evaluation
  end # Evaluation
end # Morpher
