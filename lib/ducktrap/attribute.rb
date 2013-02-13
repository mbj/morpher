class Ducktrap
  # Abstract base class for ducktrap with attribute as result
  class Attribute < self
    include AbstractType, Equalizer.new(:name)

    # Return name of attribute
    #
    # @return [Symbol] 
    #
    # @api private
    #
    attr_reader :name

    # Return postprocessor
    #
    # @return [Ducktrap]
    #
    # @api private
    #
    attr_reader :postprocessor

    # Return result for input
    #
    # @param [Object] input
    #
    # @return [Result]
    #
    # @api private
    #
    def run(input)
      result_klass.new(self, input)
    end

    # Initialize object
    #
    # @param [Symbol] name
    # @param [Ducktrap] postprocessor
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(name, postprocessor=Noop.instance)
      @name, @postprocessor = name, postprocessor
    end

  private

    # Dump object
    #
    # @param [Formatter] output
    #
    # @return [self]
    #
    # @api private
    #
    def dump(output)
      output.name(self)
      output.nest('postprocessor:', postprocessor)
    end

    # Build object
    #
    # @param [Symbol] name
    #
    # @return [Ducktrap]
    #
    # @api private
    #
    def self.build(name, &block)
      postprocessor = Noop.instance

      if block
        postprocessor = Ducktrap::Block.build(&block)
      end

      new(name, postprocessor)
    end

    # Result of attribute extractor
    class Result < Ducktrap::Result

    private

      # Return calculated value
      #
      # @return [Object]
      #   if is successful
      #
      # @return [Error]
      #   otherwise
      #
      # @api private
      #
      def process
        value = process_value
        if(value.kind_of?(Error))
          return Error.new(context, value)
        end

        result = postprocessor.run(value)

        unless result.successful?
          return Error.new(context, value)
        end

        NamedValue.new(name, result.output)
      end

      # Return postprocessor
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def postprocessor
        context.postprocessor
      end

      # Return name of attribute
      #
      # @return [Symbol]
      #
      # @api private
      #
      def name
        context.name
      end
    end

    # Ducktrap that resturns attribute from params hash 
    class ParamsHash < self
      register :attribute_from_params_hash

      # Return inverse ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def inverse 
        Ducktrap::ParamsHash::Attribute.new(name, postprocessor.inverse)
      end

      # Error on missing keys
      class MissingKeyError < Ducktrap::Error

        # Initialize object
        #
        # @param [Ducktrap] context
        # @param [Object] input
        # @param [Symbol] key
        #
        # @return [undefined]
        #
        # @api private
        #
        def initialize(context, input, key)
          @key = key
          super(context, input)
        end
      end

      # Result for params hash extractor
      class Result < Ducktrap::Attribute::Result

      private

        # Return key
        #
        # @return [String]
        #
        # @api private
        #
        def key
          name.to_s
        end

        # Return processed value
        #
        # @return [Object]
        #   if successful
        #
        # @return [Error]
        #   otherwise
        #
        # @api private
        #
        def process_value
          input.fetch(key) do
            return MissingKeyError.new(context, input, key)
          end
        end
      end
    end
  end
end
