class Ducktrap
  class String < self
    class Fixnum < self
      register :fixnum_from_string
      include Nullary

      def inverse_klass
        Ducktrap::Fixnum::String
      end

      def run(input)
        match = REGEXP.match(input)
        unless match
          return Result::Invalid.new(self, input)
        end
        Result::Static.new(self, input, input.to_i(10))
      end


      REGEXP = /\A[0-9]+\Z/.freeze
    end

    class ParamsHash < self
      include Nullary

      # Base class for params hash results that are serialized to strings
      class Result < Ducktrap::Result
      end

      class URLEncoded < self

        def inverse_klass
          Ducktrap::ParamsHash::String::URLEncoded
        end

        class Result < ParamsHash::Result
          def process
            Addressable::URI.form_encode(input)
          end
        end
      end
    end
  end
end
