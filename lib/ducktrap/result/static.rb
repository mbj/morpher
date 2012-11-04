class Ducktrap
  class Result
    class Invalid < self
      attr_reader :output
      def initialize(context, input)
        super(context, input)
        @output = error
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
