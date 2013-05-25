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

    end # Noop

    # Static evaluator with static output
    class Static < Noop
      include Concord::Public.new(:context, :input, :output)
    end # Static

  end # Evaluator
end # Ducktrap
