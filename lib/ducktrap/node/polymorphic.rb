module Ducktrap
  class Node 
    # Namespace for polymorphic mappings.
    class Polymorphic < self
      class Type < self
        include Unary

        # Return key
        # 
        # @return [Object] 
        #
        # @api private
        #
        attr_reader :key

        # Return model
        #
        # @return [Object]
        #
        # @api private
        #
        attr_reader :model

        # Initialize object
        #
        # @param [Object] key
        # @param [Object] model
        # @param [Ducktrap] operand
        #
        # @return [undefined]
        #
        def initialize(key, model, operand)
          @key, @model = key, model
          super(operand)
        end

      private

        # Dump object
        #
        # @param [Formatter] output
        #
        # @return [undefined]
        #
        # @api private
        #
        def dump(output)
          output.name(self)
          output.puts("key: #{key.inspect}")
          output.puts("model: #{model.inspect}")
          output.nest('operand:', operand)
        end

        # Polymorphic loader
        class Loader < self

          # Return inverse ducktrap
          #
          # @return [Ducktrap]
          #
          # @api private
          #
          def inverse
            Polymorphic::Type::Dumper.new(key, model, operand.inverse)
          end

          # Evaluator for polymorphic loader
          class Evaluator < Unary::Evaluator

          private

            # Process evaluator 
            #
            # @return [Object]
            #
            # @api private
            #
            def process
              body = input.fetch('body')
              evaluator = operand.run(body)
              unless evaluator.successful?
                return NAry::MemberError.new(context, input, evaluator)
              end
              evaluator.output
            end

          end
        end

        # Polymorphic dumper
        class Dumper < self

          # Return inverse ducktrap
          #
          # @return [Ducktrap]
          #
          # @api private
          #
          def inverse
            Polymorphic::Type::Loader.new(key, model, operand.inverse)
          end

          # Evaluator for polymorphic dumper
          class Evaluator < Unary::Evaluator

          private

            # Process evaluator 
            #
            # @return [Object]
            #
            # @api private
            #
            def process
              context = self.context

              evaluator = operand.run(input)
              unless evaluator.successful?
                return NAry::MemberError.new(context, input, evaluator)
              end

              { 'type' => context.key, 'body' => evaluator.output }
            end

          end
        end
      end

      # Polymorphic map
      class Map < self
        include NAry

        # Loader for polymorphic mapper
        class Loader < self

          # Return mapping
          #
          # @return [Hash]
          #
          # @api private
          #
          def mapping
            body.each_with_object({}) do |context, hash|
              hash[context.key] = context
            end
          end
          memoize :mapping

          # Return mapper for key
          #
          # @param [Object] key
          #
          # @return [undefined]
          #
          # @api private
          #
          def mapper(key)
            mapping.fetch(key)
          end

          # Return inverse ducktrap
          #
          # @return [Ducktrap]
          #
          # @api private
          #
          def inverse
            Polymorphic::Map::Dumper.new(body.map(&:inverse))
          end

          # Evaluator for polymorphic map loader
          class Evaluator < NAry::Evaluator

          private

            # Process evaluator 
            #
            # @return [Object]
            #
            # @api private
            #
            def process
              mapper = context.mapper(input.fetch('type'))
              evaluator = mapper.run(input)
              unless evaluator.successful?
                return NAry::MemberError.new(context, input, evaluator)
              end
              evaluator.output
            end

          end
        end

        # Polymorpic map dumper 
        class Dumper < self

          # Return mapping
          #
          # @return [Hash]
          #
          # @api private
          #
          def mapping
            body.each_with_object({}) do |context, hash|
              hash[context.model] = context
            end
          end
          memoize :mapping

          # Return inverse ducktrap
          #
          # @return [Ducktrap]
          #
          # @api private
          #
          def inverse
            Polymorphic::Map::Loader.new(body.map(&:inverse))
          end

          # Return mapper for class
          #
          # @param [Class] klass
          #
          # @return [Ducktrap]
          #
          # @api private
          #
          def mapper(klass)
            mapping.fetch(klass)
          end

          # Evaluator for polymorpic map dumper
          class Evaluator < NAry::Evaluator

          private

            # Process evaluator 
            #
            # @return [Object]
            #
            # @api private
            #
            def process
              mapper = context.mapper(input.class)
              evaluator = mapper.run(input)
              unless evaluator.successful?
                return nested_error(evaluator)
              end
              evaluator.output
            end

          end
        end
      end
    end
  end
end
