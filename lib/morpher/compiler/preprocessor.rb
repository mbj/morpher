module Morpher
  class Compiler

    # TODO: Preprocessors are not supposed to be instanciated, so inheritance from evaluator does not make sense.
    class Preprocessor < Evaluator
      extend NodeHelpers

      # Build from preprocessed node
      #
      # @return [Evaluator]
      #
      # @api private
      #
      def self.build(compiler, node)
        compiler.call(transform(node))
      end

      abstract_singleton_method :transform

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
        def self.transform(node)
          key, operand = *node
          s(:key_transform, key.to_s, key.to_sym, operand)
        end
        private_class_method :transform

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
        def self.transform(node)
          from, to, operand = *node
          s(:block,
            s(:key_fetch, from),
            operand,
            s(:key_dump, to)
          )
        end
        private_class_method :transform

      end # KeyTransform
    end # Preprocessor
  end # Compiler
end # Morpher
