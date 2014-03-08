module Morpher
  class Compiler
    class Preprocessor
      # Abstract preprocessor emitter
      class Emitter < Compiler::Emitter
        include Registry, Concord.new(:preprocessor, :node)

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

      end # Emitter

    end # Preprocessor
  end # Compiler
end # Morpher
