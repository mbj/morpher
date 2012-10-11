class Ducktrap
  class Result
    class Params
      class Rack
        
        # Mutation result for multipart form data in rack envs
        #
        # TODO: 
        #   Delegating to rack does not make me happy here. 
        #   Should add a more clean parser -- mbj
        #
        class MultipartFormData < self

        private

          # Deserialize input
          #
          # @return [Hash]
          #   nested params hash in case of success
          #
          # @return [Undefined]
          #   otherwise
          #
          def result
            Rack::Multipart::Parser.new(env).parse
          rescue EOFError => exception
            raise unless exception.message == 'bad content body'
            Undefined
          end
        end
      end
    end
  end
end
