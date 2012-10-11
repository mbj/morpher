class Ducktrap
  class Result
    class Params 

      # Mutation result for urlencoded params
      #
      # TODO:
      #   Dislike to delegate to rack here. 
      #   Should add more clean parser sometime. -- mbj
      #
      class URLEncoded < self

      private

        # Deserialize input
        #
        # @return [Hash]
        #   nested params hash in case of success
        #
        # @rewturn [Undefined]
        #   otherwise
        #
        def result
          ::Rack::Utils.parse_nested_query(input)
        rescue TypeError => exception
          raise unless exception.message =~ %r(\AExpected (?:Array|Hash))
          Undefined
        end

      end
    end
  end
end
