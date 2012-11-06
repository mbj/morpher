class Ducktrap
  class Formatter
    include Adamantium::Flat
    def initialize(level=0)
      @output, @level = $stdout, level
    end

    def prefix
      "  " * @level
    end
    memoize :prefix
    
    def puts(string)
      @output.write(prefix)
      @output.puts(string)
    end

    def indent
      self.class.new(@level+1)
    end
  end

  class Error 
    include Adamantium::Flat, Equalizer.new(:context, :input)

    attr_reader :context
    attr_reader :input

    def pretty_dump(output = Formatter.new)
      output.puts("#{self.class}:")
      output = output.indent
      output.puts("input: #{input.inspect}")
      output.puts("context:")
      context.pretty_dump(output.indent)
      self
    end

  private

    def initialize(context, input)
      @context, @input = context, input
    end
  end
end
