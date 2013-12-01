module Morpher
  class Evaluator
    class Transformer
      # Abstract namespace class for evaluators operating on hash keys
      class Key < self
        include AbstractType, Nullary, Parameterized

        # Evaluator for dumping hash keys
        class Dump < self

          register :key_dump

          # Call evaluator
          #
          # @param [Object] object
          #
          # @return [Array]
          #
          # @api private
          #
          def call(object)
            [param, object]
          end

          # Return inverse evaluator
          #
          # @return [Fetch]
          #
          # @api private
          #
          def inverse
            Fetch.new(param)
          end

        end # Dump

        # Evaluator to fetch a specific hash key
        class Fetch < self

          register :key_fetch

          # Call evaluator
          #
          # @param [Hash] object
          #
          # @return [Object]
          #
          # @api private
          #
          def call(object)
            object.fetch(param)
          end

          # Return inverse evaluator
          #
          # @return [Dump]
          #
          # @api private
          #
          def inverse
            Dump.new(param)
          end

        end # Fetch
      end # Key
    end # Transformer
  end # Evaluator
end # Morpher
