class Ducktrap
  # Printer for ducktrap trees
  class Formatter
    include Adamantium::Flat

    # Return output
    #
    # @return [IO]
    #
    # @api private
    #
    attr_reader :output

    # Initialize formatter
    #
    # @param [IO] output
    # @param [Fixnum] indent
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(output = $stderr, indent = 0)
      @output, @indent = output, indent
    end

    # Return prefix at current indentation
    #
    # @return [String]
    #
    # @api private
    #
    def prefix
      "  " * @indent
    end
    memoize :prefix

    # Write name of class of object
    #
    # @param [Object] object
    #
    # @return [self]
    #
    # @api private
    #
    def name(object)
      puts(object.class.name)
      self
    end

    # Write nest with label
    #
    # @param [String] label
    # @param [#pretty_dump] nested
    #
    # @return [self]
    #
    # @api private
    #
    def nest(label, nested)
      indented = indent
      indented.puts(label)
      nested.pretty_dump(indented.indent)
      self
    end

    # Write body
    #
    # @param [Enumerable<#pretty_dump>] body
    #
    # @return [self]
    #
    # @api private
    #
    def body(body)
      indented = indent
      indented.puts('body:')
      body.each do |member|
        member.pretty_dump(indented.indent)
      end
      self
    end
    
    # Write string with indentation
    #
    # @param [String] string
    #
    # @return [self]
    #
    # @api private
    #
    def puts(string)
      @output.write(prefix)
      @output.puts(string)
      self
    end

    # Return formatter with deeper indentation indent
    #
    # @return [Formatter]
    #
    # @api private
    #
    def indent
      self.class.new(output, @indent+1)
    end
  end
end
