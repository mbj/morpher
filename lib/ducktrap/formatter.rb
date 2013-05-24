module Ducktrap
  # Printer for ducktrap trees
  class Formatter
    include Adamantium::Flat, Equalizer.new(:output, :level)

    # Return output
    #
    # @return [IO]
    #
    # @api private
    #
    attr_reader :output
    protected :output

    # Return indent
    #
    # @return [Fixnum]
    #
    # @api private
    #
    attr_reader :level
    protected :level

    # Initialize formatter
    #
    # @param [IO] output
    # @param [Fixnum] indent
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(output = $stderr, level = 0)
      @output, @level = output, level
    end

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
      indented.puts("#{label}:")
      nested.pretty_dump(indented.indent)
      self
    end

    # Write labeled value
    #
    # @param [#to_str] name
    # @param [#inspect] value
    #
    # @return [self]
    #
    # @api private
    #
    def attribute(name, value)
      indented = indent
      indented.puts("#{name}: #{value.inspect}")
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
      output = self.output
      output.write(prefix)
      output.puts(string)
      self
    end

    # Return formatter with deeper indentation indent
    #
    # @return [Formatter]
    #
    # @api private
    #
    def indent
      self.class.new(output, level+1)
    end
    memoize :indent

  private

    INDENT = '  '.freeze

    # Return prefix at current indentation
    #
    # @return [String]
    #
    # @api private
    #
    def prefix
      INDENT * level
    end
    memoize :prefix

  end
end
