# encoding: UTF-8

module Morpher
  class Compiler
    class Preprocessor
      class Emitter

        # Wrap transformer preprocessor
        class Wrap < self

          register :wrap

          children :name, :attributes

        private

          # Return transformed node
          #
          # @param [Node] node
          #
          # @return [Node]
          #
          # @api private
          #
          def processed_node
            s(:_wrap, s(:static, name), s(:static, attributes))
          end

        end # Wrap

        # Unwrap transformer preprocessor
        class Unwrap < self

          register :unwrap

          children :name

        private

          # Return transformed node
          #
          # @param [Node] node
          #
          # @return [Node]
          #
          # @api private
          #
          def processed_node
            s(:_unwrap, s(:static, name))
          end

        end # Unwrap
      end # Emitter
    end # Preprocessor
  end # Compiler
end # Morpher
