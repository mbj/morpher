module Morpher
  class Compiler
    # Abstract target indepentand emitter
    class Emitter
      include AbstractType, Adamantium::Flat, NodeHelpers, Procto.call(:output)

      # Return output of emitter
      #
      # @return [Object]
      #
      # @api private
      #
      abstract_method :output

      # Return node
      #
      # @return [Node]
      #
      # @api private
      #
      abstract_method :node
      private :node

    private

      # Return children
      #
      # @return [Array<AST::Node>]
      #
      # @api private
      #
      def children
        node.children
      end

      # Assert number of child nodes
      #
      # @return [self]
      #   if assertion is fullfilled
      #
      # @raise [NodeError]
      #   otherwise
      #
      # @api private
      #
      def assert_children_amount(expected_amount)
        actual_amount = children.length
        unless actual_amount == expected_amount
          raise Error::NodeChildren.new(node, expected_amount)
        end
      end

      # Name children
      #
      # @return [undefined]
      #
      # @api private
      #
      def self.children(*names)
        names.each_with_index do |name, index|
          define_method(name) do
            children.at(index)
          end
          private name

          define_method(:named_children) do
            names
          end
          private :named_children
        end
      end
      private_class_method :children

    end # Emitter
  end # Compiler
end # Morpher
