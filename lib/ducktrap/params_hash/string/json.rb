class Ducktrap
  class ParamsHash
    class String

      # Ducktrap for json encoded params hash
      class JSON < self
        register :params_hash_from_json_string

        # Return inverse ducktrap
        #
        # @return [Ducktrap]
        #
        # @api privateo
        #
        def inverse; Nullary::String::JSON; end

        class Result < String::Result

        private

          # Deserialize input
          #
          # @return [Hash]
          #   nested params hash in case of success
          #
          # @return [Error]
          #   otherwise
          #
          # @api private
          #
          def deserialize
            MultiJSON.load(input)
          end

        end
      end
    end
  end
end
