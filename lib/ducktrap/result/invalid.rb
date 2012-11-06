class Ducktrap
  class Result
    class Invalid < self
      attr_reader :output
      def initialize(context, input)
        super(context, input)
        @output = error
      end
    end
  end
end
