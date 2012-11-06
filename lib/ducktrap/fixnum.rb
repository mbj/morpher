class Ducktrap
  class Fixnum < self
    class String < self
      register :fixnum_from_string

      def inverse_klass
        Ducktrap::String::Fixnum
      end

      def run(input)
        match = REGEXP.match(input)
        unless match
          return Result::Invalid.new(self, input)
        end
        Result::Static.new(self, input, input.to_i(10))
      end

      include Nullary

      REGEXP = /\A[0-9]+\Z/.freeze
    end
  end
end
