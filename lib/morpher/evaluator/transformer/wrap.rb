# encoding: UTF-8

module Morpher
  class Evaluator
    class Transformer

      module TVA

        module Transitive

          include Transformer::Transitive

          # Return inverse evaluator
          #
          # @return [Evaluator]
          #
          # @api private
          #
          def inverse
            attributes = body.last.call(nil).invert
            inverse_transformer.new([body.first, Static.new(attributes)])
          end

        end

        # Call evaluator
        #
        # @param [Object] input
        #
        # @return [Object]
        #
        # @api private
        #
        def call(input)
          invoke(input)
        rescue ArgumentError, TypeError
          raise_transform_error(input)
        end

        # Return evaluation
        #
        # @param [Object] input
        #
        # @return [Evaluation]
        #
        # @api private
        #
        def evaluation(input)
          evaluation_success(input, invoke(input))
        rescue ArgumentError, KeyError
          evaluation_error(input)
        end

      end # Invocation

      # Transformer for wrapping attributes under a new key
      class Wrap < self

        include Nary, TVA, TVA::Transitive

        register :_wrap

        private

        # Invoke the wrap transformation
        #
        # @return [Hash]
        #
        # @raise [ArgumentError, TypeError]
        #   if wrap does not succeed
        #
        # @api private
        #
        def invoke(input)
          tva_name  = body.first.call(input)
          tva_attrs = body.last.call(input)

          tva = tva_attrs.each_with_object({}) { |(old, new), hash|
            hash[new] = input.fetch(old)
          }

          input.
            reject { |k,_| tva_attrs.key?(k) }.
            update(tva_name => tva)
        end

        def inverse_transformer
          Unwrap::Renamed
        end

      end # Wrap

      # Transformer for unwrapping wrapped attributes
      class Unwrap < self

        include Nary, TVA, AbstractType

        class Renamed < self

          include TVA::Transitive

          register :renamed_unwrap

          private

          # Invoke the unwrap transformation
          #
          # @param [Object] input
          #
          # @return [Hash]
          #
          # @raise [ArgumentError, TypeError]
          #   if wrap does not succeed
          #
          # @api private
          #
          def invoke(input)
            tva_name  = body.first.call(input)
            tva_attrs = body.last.call(input)

            tva = input.fetch(tva_name).each_with_object({}) { |(k, v), hash|
              hash[tva_attrs.fetch(k)] = v
            }

            input.
              reject { |k,_| k == tva_name }.
              update(tva)
          end

          def inverse_transformer
            Wrap
          end

        end # Renamed

        class Simple < self

          include Intransitive

          register :simple_unwrap

          private

          # Invoke the unwrap transformation
          #
          # @param [Object] input
          #
          # @return [Hash]
          #
          # @raise [ArgumentError, TypeError]
          #   if wrap does not succeed
          #
          # @api private
          #
          def invoke(input)
            tva_name  = body.first.call(input)
            tva       = input.fetch(tva_name)

            input.
              reject { |k,_| k == tva_name }.
              update(tva)
          end
        end # Simple
      end # Unwrap
    end # Transformer
  end # Evaluator
end # Morpher
