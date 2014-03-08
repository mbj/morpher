module Morpher
  class Compiler
    # Abstract target indepentand emitter
    class Emitter
      include AbstractType, Adamantium::Flat, NodeHelpers

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

    end # Emitter
  end # Compiler
end # Morpher
