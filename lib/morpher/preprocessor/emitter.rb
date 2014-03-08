module Morpher
  class Preprocessor
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
    end # Emitter
  end # Preprocessor
end # Morpher
