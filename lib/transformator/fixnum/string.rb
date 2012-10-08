class Transformator
  class Fixnum

    # Transformator to fixnum from string
    class String < self

      register :fixnum_from_string

      INTEGER_REGEXP = /\A[-+]?(?:0|[1-9]\d*)\Z/.freeze

      # Load fixnum
      #
      # @api private
      #
      # @return [Fixnum]
      #   if valid
      #
      # @return [Undefined]
      #   otherwise
      #
      # @api private
      #
      def load
        match = self.match
        if match
          match[0].to_i(10)
        else
          Undefined
        end
      end

      # Return match
      #
      # @return [MatchData]
      #
      # @api private
      #
      def match
        INTEGER_REGEXP.match(input)
      end
      memoize :match

    end
  end
end
