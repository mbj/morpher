class Ducktrap

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

  end
end
