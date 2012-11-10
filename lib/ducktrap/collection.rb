class Ducktrap
  class Collection < self
    include Unary

    register :collection

    def inverse
      self.class.new(operand.inverse)
    end

    class Result < Unary::Result

    private

      def process
        input.map do |element|
          result = operand.run(element)
          unless result.successful?
            raise
          end
          result.output
        end
      end
    end
  end
end
