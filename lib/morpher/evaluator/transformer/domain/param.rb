# encoding: UTF-8

module Morpher
  class Evaluator
    class Transformer
      class Domain < self

        # Domain specific transformer parameter
        class Param
          include Adamantium, Concord::Public.new(:model, :attribute_names)

          # Return instance variable names
          #
          # @return [Enumerable<Symbol>]
          #
          # @api private
          #
          def instance_variable_names
            attribute_names.map do |name|
              :"@#{name}"
            end
          end
          memoize :instance_variable_names

        end # Param

      end # Domain
    end # Transformer
  end # Evaluator
end # Morpher
