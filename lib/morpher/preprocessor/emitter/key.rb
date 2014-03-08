module Morpher
  class Preprocessor
    class Emitter

      # Namespace class for key preprocessors
      class Key < self
        include AbstractType

        # Key symbolization preprocessor
        class Symbolize < self

          register :key_symbolize

          # Return transformed node
          #
          # @param [Node] node
          #
          # @return [Node]
          #
          # @api private
          #
          def output
            key, operand = *node
            s(:key_transform, key.to_s, key.to_sym, operand)
          end

        end # Symbolize

        # Key transformation preprocessor
        class Transform < self
          register :key_transform

          # Return transformed node
          #
          # @param [Node] node
          #
          # @return [Node]
          #
          # @api private
          #
          def output
            from, to, operand = *node
            s(:block,
              s(:key_fetch, from),
              visit(operand),
              s(:key_dump, to)
            )
          end

        end # Transform

      end  # Key
    end # Emitter
  end # Preprocessor
end # Morpher
