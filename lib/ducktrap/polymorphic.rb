class Ducktrap
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

        # Result for polymorphic loader
        class Result < Unary::Result

        private

          # Process result 
          #
          # @return [Object]
          #
          # @api private
          #
          def process
            body = input.fetch('body')
            result = operand.run(body)
            unless result.successful?
              return Nary::MemberError.new(context, input, result)
            end
            result.output
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

        # Result for polymorphic dumper
        class Result < Unary::Result

        private

          # Process result 
          #
          # @return [Object]
          #
          # @api private
          #
          def process
            context = self.context

            result = operand.run(input)
            unless result.successful?
              return Nary::MemberError.new(context, input, result)
            end

            { 'type' => context.key, 'body' => result.output }
          end

        end
      end
    end

    # Polymorphic map
    class Map < self
      include Nary

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

        # Result for polymorphic map loader
        class Result < Nary::Result

        private

          # Process result 
          #
          # @return [Object]
          #
          # @api private
          #
          def process
            mapper = context.mapper(input.fetch('type'))
            result = mapper.run(input)
            unless result.successful?
              return Nary::MemberError.new(context, input, result)
            end
            result.output
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

        # Result for polymorpic map dumper
        class Result < Nary::Result

        private

          # Process result 
          #
          # @return [Object]
          #
          # @api private
          #
          def process
            mapper = context.mapper(input.class)
            result = mapper.run(input)
            unless result.successful?
              return Nary::MemberError.new(context, input, result)
            end
            result.output
          end

        end
      end
    end
  end
end
