module Ducktrap

  # Error returned for invalid inputs
  class Error 
    include PrettyDump, Adamantium::Flat, Concord.new(:context, :input)

  private

    # Dump state to output
    #
    # @param [Formatter] formatter
    #
    # @return [undefined]
    #
    # @api private
    #
    def dump(output)
      output.name(self)
      output = output.indent
      output.attribute(:input, input)
      output.nest(:context, context)
    end

    # Error caused by exception
    class Exception < self
      include Concord.new(:context, :input, :exception)

    private

      # Dump state to output
      #
      # @param [Formatter] formatter
      #
      # @return [undefined]
      #
      # @api private
      #
      def dump(output)
        exception = self.exception
        output.name(self)
        output = output.indent
        output.attribute(:input, input)
        output.name(exception)
        output.attribute(:exception, exception.message)
        output.nest(:context, context)
      end
    end

  end
end
