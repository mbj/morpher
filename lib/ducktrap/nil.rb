class Ducktrap
  # Abstract class for ducktrap that results in nil
  class Nil < Abstract::Nullary
    include AbstractClass

    # Abstract class for nil results
    class Result < Ducktrap::Result
      include AbstractClass
    end

    # Ducktrap that builds nil from empty data structures 
    class Empty < self
      class Result < Result

      private

        # Calculate result
        #
        # @api private
        #
        # @return [Nil]
        #   if input is #empty?
        #
        # @return [Undefined]
        #   if input does not respond to #empty?
        #
        # @return [Object]
        #   otherwise
        #
        # @api private
        #
        def result
          if input.respond_to?(:empty?) and input.empty?
            return nil
          end

          Undefined
        end
      end

      RESULT = Result

      register :nil_if_empty
    end

    # Ducktrap that builds nil from empty data structures 
    class EmptyString < self
      INSTANCE = Ducktrap::NAry::Block.new do |block|
        block.primitive(String)
        block.nil_if_empty
      end

      # Return empty string ducktrap
      #
      # @return [Ducktrap]
      #
      # @api private
      #
      def self.new; INSTANCE; end

      register :nil_from_empty_string
    end
  end
end
