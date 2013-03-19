module Ducktrap
  class Error 
    include Adamantium::Flat, Concord.new(:context, :input)

    # Perform pretty dump
    #
    # @return [self]
    #
    # @api private
    #
    def pretty_dump(output = Formatter.new)
      output.puts("#{self.class}:")
      output = output.indent
      output.puts("input: #{input.inspect}")
      output.puts("context:")
      context.pretty_dump(output.indent)
      self
    end

  end
end
