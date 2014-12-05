# encoding: UTF-8

module Morpher
  class Evaluator
    module Unary
      # Mixin to define parameterized nullary evaluators
      module Parameterized

        CONCORD = Concord::Public.new(:param, :operand)

        PRINTER = lambda do |_|
          name
          indent do
            attribute :param
            visit(:operand)
          end
        end

        # Hook called when module gets included
        #
        # @return [undefined]
        #
        # @api private
        #
        def self.included(descendant)
          descendant.class_eval do
            include InstanceMethods, Unary::InstanceMethods, CONCORD
            printer(&PRINTER)
          end
        end
        private_class_method :included

        # Mixin for nullary parameterized evaluators
        module InstanceMethods

          # Return node
          #
          # @return [AST::Node]
          #
          # @api private
          #
          def node
            s(type, param, operand.node)
          end
        end # InstanceMethods
      end # Nullary
    end # Parameterized
  end # Evaluator
end # Morpher
