class Ducktrap
  class Fixnum < self
    include Singleton

    class String < self
      register :fixnum_from_string

      REGEXP = /\A[0-9]+\Z/.freeze

      # Return inverse klass
      #
      # @return [Class:Ducktrap::String::Fixnum]
      #
      # @api private
      #
      def inverse_klass
        Ducktrap::String::Fixnum
      end

      # Return result for input
      #
      # @param [Object] input
      #
      # @api private
      #
      def run(input)
        match = REGEXP.match(input)

        unless match
          return Result::Invalid.new(self, input)
        end

        Result::Static.new(self, input, input.to_i(10))
      end

    end
  end
end
