# encoding: UTF-8

module Morpher
  class Evaluator
    module Nullary
      # Mixin to define parameterized nullary evaluatos
      module Parameterized

        CONCORD = Concord::Public.new(:param)

        PRINTER = lambda do |_|
          name
          indent do
            attribute :param
          end
        end

        # Mixin for nullary parameterized evaluators
        module InstanceMethods

          # Return node
          #
          # @return [Morpher::Node]
          #
          # @api private
          #
          def node
            s(type, param)
          end

        end # InstanceMethods

        # Hook called when module gets included
        #
        # @return [undefined]
        #
        # @api private
        #
        def self.included(descendant)
          descendant.class_eval do
            include InstanceMethods, Nullary::InstanceMethods, CONCORD
            printer(&PRINTER)
          end
        end
        private_class_method :included

      end # Nullary
    end # Parameterized
  end # Evaluator
end # Morpher
