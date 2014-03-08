# encoding: UTF-8

module Morpher
  class Evaluator
    class Transformer
      class Domain < self
        # Abstract namespace class for domain objects on attributes hash
        class AttributesHash < self
          include AbstractType

          # Evaluator for dumping domain objects via attributes hash
          class Dump < self

            register :dump_attributes_hash

            # Call evaluator
            #
            # @param [Object] input
            #
            # @return [Hash<Symbol, Object>]
            #
            # @api private
            #
            def call(input)
              input.to_h
            end

            # Return inverse evaluator
            #
            # @return [Evaluator]
            #
            # @api private
            #
            def inverse
              Load.new(param)
            end

          end # Dump

          # Evaluator for loading domain objects via attributes hash
          class Load < self

            register :load_attributes_hash

            # Call evaluator
            #
            # @param [Object] input
            #
            # @return [Object]
            #   an instance of an anima infected class
            #
            # @api private
            #
            def call(input)
              invoke(input)
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
            end

            # Return inverse evaluator
            #
            # @return [Evaluator]
            #
            # @api private
            #
            def inverse
              Dump.new(param)
            end

          private

            # Invoke the transformation
            #
            # @return [Object]
            #
            # @api private
            #
            def invoke(input)
              param.new(input)
            end

          end # Load
        end # Domain
      end # Anima
    end # Transformer
  end # Evaluator
end # Morpher
