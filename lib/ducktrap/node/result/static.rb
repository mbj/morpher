class Ducktrap
  class Result

    # Static result with input as output
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

    # Static result with static output
    class Static < Noop
      include Concord.new(:context, :input, :output)
    end
  end
end
