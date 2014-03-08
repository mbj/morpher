# encoding: UTF-8

module Morpher
  class Evaluator
    class Transformer
      class Domain
        # Abstract namespace class for domain objects via attribute accessors
        class AttributeAccessors < self
          include AbstractType

          # Evaluator for dumping domain objects via instance variables
          class Dump < self

            register :dump_attribute_accessors

            # Call evaluator
            #
            # @param [Object] input
            #
            # @return [Hash<Symbol, Object>]
            #
            # @api private
            #
            def call(input)
              param.attribute_names.each_with_object({}) do |name, aggregate|
                value = input.public_send(name)
                aggregate[name] = value
              end
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

            register :load_attribute_accessors

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
              object = param.model.allocate
              param.attribute_names.each do |name|
                object.public_send(:"#{name}=", input.fetch(name))
              end
              object
            end

          end # Load
        end # Domain
      end # Anima
    end # Transformer
  end # Evaluator
end # Morpher
