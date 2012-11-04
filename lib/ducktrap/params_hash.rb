class Ducktrap
  # Abstract base class for ducktraps that result in params hash
  class ParamsHash < self

    # Base class for ducktraps that load params hashes from string
    class String < self
      include Nullary

      # Base class for params hash results that are deserialized from strings
      class Result < Ducktrap::Result
        include Nullary::Result

      private

        abstract_method :deserialize

        def process
          object = deserialize
          if object.kind_of?(Hash)
            object
          else
            error
          end
        end
      end

      # Ducktrap for json encoded params hash
      class JSON < self
        register :params_hash_from_json_string

        def inverse; Nullary::String::JSON; end

        class Result < String::Result
        private
          # Deserialize input
          #
          # @return [Hash]
          #   nested params hash in case of success
          #
          # @rewturn [Undefined]
          #   otherwise
          #
          def deserialize
            MultiJSON.load(input)
          end
        end
      end

      # Ducktrap for url encoded params hash
      class URLEncoded < self
        register :params_hash_from_url_encoded_string

        def inverse; String::URLEncoded; end

        class Result < String::Result

        private

          class DuplicateKeyError < Ducktrap::Error
            attr_reader :key

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
          # @return [Undefined]
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
