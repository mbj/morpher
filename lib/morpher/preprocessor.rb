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

end # Morpher
