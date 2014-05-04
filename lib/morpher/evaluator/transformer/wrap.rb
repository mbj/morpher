# encoding: UTF-8

module Morpher
  class Evaluator
    class Transformer

      module Invocation

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

        include Nary
        include Transitive
        include Invocation

        register :_wrap

        # Return inverse evaluator
        #
        # @return [Evaluator]
        #
        # @api private
        #
        def inverse
          Unwrap.new([body.first])
        end

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

          tva = tva_attrs.each_with_object({}) { |name, hash|
            hash[name] = input.fetch(name)
          }

          input.
            reject { |k,_| tva_attrs.include?(k) }.
            merge!(tva_name => tva)
        end

      end # Wrap

      # Transformer for unwrapping wrapped attributes
      class Unwrap < self

        include Nary
        include Intransitive
        include Invocation

        register :_unwrap

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
          tva_name = body.first.call(input)
          tva      = input.fetch(tva_name)

          input.
            reject { |k,_| k == tva_name }.
            merge!(tva)
        end

      end # Unwrap

    end # Transformer
  end # Evaluator
end # Morpher
