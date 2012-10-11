class Ducktrap
  class Result
    class Fixnum

      # Mutation result to fixnum from string
      class String < self

        INTEGER_REGEXP = /\A[-+]?(?:0|[1-9]\d*)\Z/.freeze

      private

        # Calculate result
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
        def result
          match = INTEGER_REGEXP.match(input)

          if match
            match[0].to_i(10)
          else
            Undefined
          end
        end

      end
    end
  end
end
