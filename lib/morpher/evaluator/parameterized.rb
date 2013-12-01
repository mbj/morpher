module Morpher
  class Evaluator
    # Mixin to define parameterized nullary evaluatos
    module Parameterized

      CONCORD = Concord::Public.new(:param)

      PRINTER = lambda do |_|
        name
        indent do
          attribute :param
        end
      end

      def self.build(_compiler, node)
        new(node.children.first)
      end

      module ClassMethods

        # Build nary nodes
        #
        # @param [Compiler] _compiler
        # @param [Morpher::Node] node
        #
        # @return [Evaluator::Nary]
        #
        # @api privateo
        #
        def build(_compiler, node)
          new(node.children.first)
        end

      end # ClassMethods

      # Hook called when module gets included
      #
      # @return [self]
      #
      # @api private
      #
      def self.included(descendant)
        super
        descendant.class_eval do
          include CONCORD
          extend ClassMethods
          printer(&PRINTER)
        end
        self
      end
      private_class_method :included

    end # Parameterized
  end # Evaluator
end # Morpher
