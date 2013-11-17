module Morpher

  # Abstract namespace class for non tracking evaluators
  class Evaluator
    include AbstractType

    abstract_method :pretty_dump

    def self.register(name)
      REGISTRY[name] = self
    end

    abstract_method :call

    abstract_method :evaluation

    class Root < self

      include Concord.new(:node, :operand)

      def call(object)
        operand.call(object)
      end
    end

    class Nullary < self
      include Concord.new

    end # Nullary

    class Binary < self
      include Concord.new(:left, :right)

      class And < self

        register :and

        def call(object)
          left.call(object) && right.call(object)
        end

      end

      class Or < self

        register :or

        def call(object)
          left.call(object) || right.call(object)
        end

      end # Or

      class Xor < self

        register :or

        def call(object)
          left.call(object) ^ right.call(object)
        end

      end # XOR

    end # Binary

    class Attribute < self
      include Concord::Public.new(:name, :operand)

      register :attribute

      def pretty_dump(printer)
        printer.name(self)
        printer.attribute(self, :name)
        printer.puts('operand:')
        printer.visit_indented(operand)
        self
      end

      def call(object)
        operand.call(object.public_send(name))
      end

      def self.build(compiler, node)
        name, operand = *node
        new(name, compiler.call(operand))
      end

    end # Attribute

    class Not < self

      include Concord.new(:operand)

      register :not

      def call(object)
        !operand.call(object)
      end

    end # Not

    class Falsy < self

      register :falsy

      include Concord.new(:operand)

      def call(object)
        !operand.call(object)
      end

    end # Falsy

    class Truthy < self

      register :truthy

      include Concord.new(:operand)

      def call(object)
        !!operand.call(object)
      end

    end

    class Primitive < self

      include AbstractType, Concord.new(:primitive)


      class Exact < self

        register :primitive

        def call(object)
          object.class == primitive
        end

      end

      class Permissive < self

        register :is_a

        def call(object)
          object.is_a?(primitive)
        end

      end

    end

  end # Evaluator
end # Morpher
