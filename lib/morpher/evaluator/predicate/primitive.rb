# encoding: UTF-8

module Morpher
  class Evaluator
    class Predicate
      # Abstract namespace class for predicate evaluators on primitives
      class Primitive < self
        include Nullary::Parameterized

        # Evaluator for exact primitive match
        class Exact < self

          register :primitive

          # Call evalutor
          #
          # @param [Object] object
          #
          # @return [true]
          #   if objects type equals exactly
          #
          # @api private
          #
          def call(object)
            object.class.equal?(param)
          end

        end # Exact

        # Evaluator for permissive primtivie match
        class Permissive < self
          register :is_a

          # Call evalutor
          #
          # @param [Object] object
          #
          # @return [true]
          #   if objects type equals exactly
          #
          # @api private
          #
          def call(object)
            object.is_a?(param)
          end

        end # Permissive
      end # Primitive
    end # Predicate
  end # Evaluator
end # Morpher
