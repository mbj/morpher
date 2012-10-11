class Ducktrap
  class Result

    # Namespace for abstract results
    module Abstract
      class NAry < Result
        include AbstractClass 

      private

        # Return result enumerator
        #
        # @return [self]
        #   if block given
        #
        # @return [Enumerator<Result>]
        #   othewise
        #
        # @api private
        #
        def results
          return to_enum(__method__) unless block_given?

          body.each do |ducktrap|
            yield ducktrap.run(input)
          end

          self
        end

        # Return body
        #
        # @return [Enumerable<Ducktrap>]
        #
        # @api private
        #
        attr_reader :body

        # Initialize object
        #
        # @param [Object] input
        # @param [Enumerable<Ducktrap>] body
        #
        # @return [undefined]
        #
        # @api private
        #
        def initialize(input, body)
          @body = body
          super(input)
        end
      end
    end
  end
end
