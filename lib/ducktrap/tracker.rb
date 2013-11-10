module Ducktrap

  class EvaluationError < RuntimeError
    include Concord::Public.new(:error)
  end

  class Evaluation
    include Adamantium::Flat, Concord::Public.new(:evaluator, :input, :output)

    def success?
      evaluator.success?(output)
    end
    memoize :success?

  end # Evaluation

  class Error
    include Adamantium::Flat, AbstractType

    def description
      io = StringIO.new
      Printer.new(io).visit(self)
      io.rewind
      io.read
    end
    memoize :description

    class Leave < self
      include Concord::Public.new(:node, :input)
    end

    class Nested < self
      include Concord::Public.new(:child, :node, :input)
    end

    class Printer
      include Concord.new(:io, :indent)

      def self.new(io)
        super(io, 0)
      end

      INDENT = '  '.freeze

      def visit(error)
        case error
        when Leave
          visit_leave(error)
        when Nested
          visit_nested(error)
        end
      end

    private

      def visit_leave(error)
        visit_node(error.node)
      end

      def visit_node(node)
        case node
        when Evaluator
          visit_evaluator(node)
        when Tracker
          visit_evaluator(node.evaluator)
        end
      end

      def visit_evaluator(evaluator)
        puts("evaluator: #{evaluator.class}")
        attribute(evaluator, :input)
      end

      def attribute(object, name)
        indented do
          puts "#{name}: #{object.public_send(name)}"
        end
      end

      def indented
        @indent += 1
        yield
        @indent -= 1
      end

      def puts(string)
        io.puts(INDENT * indent + string)
      end

    end # Printer

  end # Error

  class Tracker
    include AbstractType, Adamantium, Concord::Public.new(:evaluator)

    abstract_method :call

  private

    def evaluation(input)
      output = evaluator.call(input)
      Evaluation.new(evaluator, input, output)
    end


    class Root < self

      def call(object)
        evaluation = evaluation(object)

        if evaluation.success?
          Result::Success.new(evaluation.output)
        else
          Result::Error.new('root error')
        end

      rescue EvaluationError => exception
        Result::Error.new(exception.error)
      end

    end # Root

    class Inner < self

      def call(object)
        output = evaluator.call(object)

        if evaluator.success?(output)
          output
        else
          raise EvaluationError, Error::Leave.new(self, object)
        end
      end


    end # Inner

    class Result
      include AbstractType

      abstract_method :output

      abstract_method :error

      def success?
        self.class::STATE
      end

      class Success < self
        include Concord::Public.new(:output)

        STATE = true
      end # Success

      class Error < self
        include Concord::Public.new(:error)

        STATE = false

      end # Error

    end # Result

  end # Tracker
end # Ducktrap
