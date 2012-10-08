require 'rack/utils'

class Transformator
  class Params 

    # Transformator for urlencoded params
    #
    # TODO:
    #   Dislike to delegate to rack here. 
    #   Should add more clean parser sometime. -- mbj
    #
    class URLEncoded < self

      class BadNestedParamsType < Error::Wrapper; end

      register :params_from_url_encoded

    private

      # Deserialize input
      #
      # @return [Hash]
      #   nested params hash in case of success
      #
      # @rewturn [Undefined]
      #   otherwise
      #
      def load
        ::Rack::Utils.parse_nested_query(input)
      rescue TypeError => exception
        raise unless exception.message =~ %r(\AExpected (?:Array|Hash))

        exception(BadNestedParamsType, exception)

        Undefined
      end

    end
  end
end
