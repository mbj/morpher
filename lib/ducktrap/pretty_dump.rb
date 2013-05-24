module Ducktrap
  # Mixin for pretty dumpable objects
  module PrettyDump

    # Perform pretty dump of ducktrap
    #
    # @return [self]
    #
    # @api private
    #
    def pretty_dump(output=Formatter.new)
      dump(output)
      self
    end

    # Return pretty inspection
    #
    # @return [String]
    #
    # @api private
    #
    def pretty_inspect
      io = StringIO.new
      formatter = Formatter.new(io)
      pretty_dump(formatter)
      io.rewind
      io.read
    end

  end # PrettyDump
end # Ducktrap
