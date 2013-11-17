module Morpher
  class Evaluator
    class Nullary < self

      def evaluation(input)
        output = call(input)
        Evaluation.new(
          :evaluator => self,
          :input     => input,
          :output    => output
        )
      end

      class Contradiction < self

        register :true

        def call(_object)
          false
        end
      end

      class Tautology < self

        register :true

        def call(_object)
          true
        end

      end # Tautology

      class Parameterized < self
        include Concord::Public.new(:param)

        def pretty_dump(printer)
          printer.name(self)
          printer.attribute(self, :param)
          self
        end

        def self.build(_compiler, node)
          new(node.children.first)
        end

        class EQL < self


          register :eql

          def call(object)
            param.eql?(object)
          end

        end # EQL

        class KeyFetch < self

          register :key_fetch

          def call(object)
            object.fetch(param)
          end


        end # KeyFetch

      end
    end # Nullary
  end # Evaluator
end # Morpher

