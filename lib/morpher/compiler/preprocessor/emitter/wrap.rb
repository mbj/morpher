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
            attrs = if attributes.is_a?(Hash)
              attributes
            else
              Hash[attributes.zip(attributes)]
            end

            s(:_wrap, s(:static, name), s(:static, attrs))
          end

        end # Wrap

        # Unwrap transformer preprocessor
        class Unwrap < self

          register :unwrap

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
            if children.size > 1
              name, attributes = children.first, children.last
              s(:renamed_unwrap, s(:static, name), s(:static, attributes))
            else
              s(:simple_unwrap, s(:static, children.first))
            end
          end

          def validate_node
            unless [1, 2].include?(children.size)
              raise Error::NodeChildren.new(node, "1 or 2")
            end
          end

        end # Unwrap
      end # Emitter
    end # Preprocessor
  end # Compiler
end # Morpher
