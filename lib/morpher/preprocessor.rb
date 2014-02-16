# encoding: UTF-8

module Morpher

  # AST preprocessor
  class Preprocessor
    include Concord.new(:registry)

    # Call preprocessor
    #
    # @param [Node] node
    #   the raw AST node after DSL
    #
    # @return [Node]
    #   the transformed ast node
    #
    # @api private
    #
    def call(node)
      loop do
        emitter = registry.fetch(node.type, Emitter::Noop)
        node = emitter.call(self, node)
        break if emitter == Emitter::Noop
      end

      node
    end

  end # Preprocessor

  # Abstract preprocessor emitter
  class Emitter
    include Adamantium::Flat, AbstractType, NodeHelpers, Registry, Concord.new(:preprocessor, :node)

    # Return output for input
    #
    # FIXME: This should be moved to a MethodObject mixin:
    #
    # class Emitter
    #   include MethodObject.new(:output)
    # end
    #
    # @return [Node]
    #
    # @api private
    #
    def self.call(*arguments)
      new(*arguments).output
    end

    # Return output for emitter
    #
    # @return [Node]
    #
    # @api private
    #
    abstract_method :output

  private

    # Visit node
    #
    # @param [Node] node
    #   original untransformed node
    #
    # @return [Node]
    #   transformed node
    #
    # @api private
    #
    def visit(node)
      preprocessor.call(node)
    end

    # Noop emitter just descending into children
    class Noop < self

      # Return output
      #
      # @return [Node]
      #
      # @api private
      #
      def output
        mapped_children = node.children.map do |child|
          if child.kind_of?(node.class)
            visit(child)
          else
            child
          end
        end
        s(node.type, *mapped_children)
      end

    end # Noop

    # Key symbolization preprocessor
    class SymbolizeKey < self

      register :symbolize_key

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
        s(:key_transform, key.to_s, key.to_sym, visit(operand))
      end

    end

    # Key transformation preprocessor
    class KeyTransform < self
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

    end # KeyTransform
  end # Preprocessor

end # Morpher
