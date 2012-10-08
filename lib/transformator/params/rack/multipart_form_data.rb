class Transformator
  class Params
    class Rack
      
      # Transformator for multipart form data in rack envs
      #
      # TODO: 
      #   Delegating to rack does not make me happy here. 
      #   Should add a more clean parser -- mbj
      #
      class MultipartFormData < self

        class BadContentBody < Error::Wrapper; end

      private

        # Deserialize input
        #
        # @return [Hash]
        #   nested params hash in case of success
        #
        # @return [Undefined]
        #   otherwise
        #
        def deserzalize
          Rack::Multipart::Parser.new(env).parse
        rescue EOFError => exception
          raise unless exception.message == 'bad content body'

          exception(BadContentBody, exception)

          Undefined
        end
      end
    end
  end
end
