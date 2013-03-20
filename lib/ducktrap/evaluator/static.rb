module Ducktrap
  class Evaluator

    # Static evaluator with input as output
    class Noop < self

      # Return output
      #
      # @return [Object]
      #
      # @api private
      #
      def output
        input
      end

    end

    # Static evaluator with static output
    class Static < Noop
      include Concord.new(:context, :input, :output)
    end
  end
end
