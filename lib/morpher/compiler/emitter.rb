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
        end
      end

    end # Emitter
  end # Compiler
end # Morpher
