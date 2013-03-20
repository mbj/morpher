module Ducktrap
  class Node
    # Abstract baseclass for ducktraps to string
    class String < self

      # Ducktrap to convert fixnums to string
      class Fixnum < self
        register :string_from_fixnum
        include Singleton

        # Return inverse klass
        #
        # @return [Class:Ducktrap::Fixnum::String]
        #
        # @api private
        #
        def inverse_klass
          Node::Fixnum::String
        end

        # Return evaluator for input
        #
        # @param [Object] input
        #
        # @return [Evaluator]
        #
        # @api private
        #
        def run(input)
          Evaluator::Static.new(self, input, input.to_s(10))
        end

      end

      # Abstract class to convert param hashes to string
      class ParamsHash < self
        include Singleton, AbstractType

        # Base class for params hash evaluators that are serialized to strings
        class Evaluator < Ducktrap::Evaluator
        end

        # Ducktrap to convert param hashes to url encoded strings
        class URLEncoded < self

          # Return inverse class
          #
          # @return [Class:Ducktrap::ParamsHash::String::URLEncoed]
          #
          # @api private
          #
          def inverse_klass
            Ducktrap::ParamsHash::String::URLEncoded
          end

          # Resulf of url encoded string ducktrap
          class Evaluator < ParamsHash::Evaluator

          private

            # Return calculated evaluator
            #
            # @return [String]
            #
            # @api private
            #
            def process
              Addressable::URI.form_encode(input)
            end

          end

        end
      end
    end
  end
end
