module Ducktrap
  class Node
    # Node with fixnum as result
    class Fixnum < self
      include Singleton

      # Node with string as input
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
          Node::String::Fixnum
        end

        # Return evaluator for input
        #
        # @param [Object] input
        #
        # @return [Fixnum]
        #
        # @api private
        #
        def run(input)
          match = REGEXP.match(input)

          unless match
            return Evaluator::Invalid.new(self, input)
          end

          Evaluator::Static.new(self, input, input.to_i(10))
        end

      end
    end
  end
end
