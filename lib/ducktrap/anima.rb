class Ducktrap
  class Anima < self
    include Composition.new(:model)

  private

    # Perform pretty dump
    #
    # @param [Formatter] output
    #
    # @return [undefined]
    #
    # @api private
    #
    def dump(output)
      output.puts(self.class.name)
      output = output.indent
      output.puts("model: #{model}")
    end

    class AttributesHash < self
      register :anima_from_attributes_hash

      # Return inverse ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def inverse; Ducktrap::AttributesHash::Anima.new(model); end

      # Run ducktrap on input
      #
      # @param [Object] input
      #
      # @return [Result]
      #
      # @api private
      #
      def run(input)
        result_klass.new(self, input, model)
      end

      # Build ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def self.build(*args)
        new(*args)
      end

      # Result of attribute ducktrap
      class Result < Ducktrap::Result

      private

        # Process input
        #
        # @return [Object]
        #
        # @api private
        #
        def process
          @model.new(input)
        rescue ::Anima::Error
          error
        end

        # Initialize object
        #
        # @param [Ducktrap] context
        # @param [Object] input
        # @param [Class] model
        #
        # @api private
        #
        def initialize(context, input, model)
          @model = model
          super(context, input)
        end

      end
    end
  end
end
