class Ducktrap
  class ParamsHash
    class String
      # Ducktrap for url encoded params hash
      class URLEncoded < self
        register :params_hash_from_url_encoded_string

        # Return inverse class
        #
        # @return [Class:Ducktrap]
        #
        # @api private
        #
        def inverse_klass
          Ducktrap::String::ParamsHash::URLEncoded
        end

        # Result for url encoded ducktrap
        class Result < String::Result

        private

          # Error when duplicate keys shadow values
          class DuplicateKeyError < Ducktrap::Error

            # Return duplicated key
            #
            # @return [String]
            #
            # @api private
            #
            attr_reader :key

            # Initialize object
            #
            # @param [Ducktrap] context
            # @param [String] input
            # @param [String] key
            #
            # @return [undefined]
            #
            def initialize(context, input, key)
              @key = key
              super(context, input)
            end
          end

          # Return deserialized key value paris
          #
          # @return [Array]
          #
          # @api private
          #
          def deserialized
            Addressable::URI.form_unencode(input)
          end
          memoize :deserialized

          # Deserialize input
          #
          # @return [Hash]
          #   nested params hash in case of success
          #
          # @return [Error]
          #   otherwise
          #
          def deserialize
            deserialized.each_with_object({}) do |(key, value), hash|
              if hash.key?(key)
                return DuplicateKeyError.new(context, input, key)
              end

              hash[key]=value
            end
          end

        end
      end
    end
  end
end
