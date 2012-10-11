class Ducktrap
  class Result

    # Abstract base class for mutation result that is a single attribute
    class Attribute < self
      include AbstractClass

      # Include default equalizer
      #
      # @return [self]
      #
      def self.default_equalizer
        include Equalizer.new(:input, :name, :output, :postprocessor)
      end
      private_class_method :default_equalizer

      # Return name
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

    private

      # Initialize object
      #
      # @param [Object] input
      # @param [Symbol] name
      # @param [Ducktrap] postprocessor
      #
      def initialize(input, name, postprocessor)
        @name = name
        @postprocessor = postprocessor
        super(input)
      end

      # Return inner input extracted from input
      #
      # @return [Object]
      #   if inner input is valid
      #
      # @return [Undefined]
      #   otherwise
      #
      # @api private
      #
      abstract_method :inner_input

      # Calculate result
      #
      # @return [Object]
      #   postprocessing result
      #
      # @return [nil]
      #   otherwise
      #
      def result
        input = inner_input
        unless input == Undefined
          postprocess(inner_input)
        else
          Undefined
        end
      end

      # Postprocess result
      #
      # @param [Object] input
      #
      # @return [Object] 
      #   if successful
      #
      # @return [Undefined]
      #   otherwise
      #
      # @api private
      #
      def postprocess(input)
        @postprocessor.run(input).output
      end
    end
  end
end
