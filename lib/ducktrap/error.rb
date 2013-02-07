class Ducktrap
  class Error 
    include Adamantium::Flat, Composition.new(:context, :input)

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
