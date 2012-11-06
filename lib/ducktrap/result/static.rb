class Ducktrap
  class Result
    class Noop < self
      attr_reader :output

      def initialize(context, input)
        super(context, input)
        @output = input
      end
    end

    class Static < self
      attr_reader :output
      def initialize(context, input, output)
        super(context, input)
        @output = output
      end
    end
  end
end
