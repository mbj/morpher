module Ducktrap

  # Namespace for success mixins
  module Success
    module True
      def success?(object)
        object.equal?(true)
      end
    end

    module Always
      def success?(_object)
        true
      end
    end
  end # Success

  # Abstract namespace class for non tracking evaluators
  class Evaluator
    include AbstractType

    abstract_method :success?

    def self.register(name)
      REGISTRY[name] = self
    end

    abstract_method :call

    class EQL < self
      include Concord.new(:value), Success::True

      register :eql

      def call(object)
        object.eql?(value)
      end

      def self.build(compiler, node)
        new(node.children.first)
      end

    end

    class Root < self

      include Concord.new(:node, :operand)

      def call(object)
        operand.call(object)
      end
    end

    class Nullary < self
      include Concord.new

      def self.build(compiler, node)
        new
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
      include Concord.new(:name, :operand), Success::Always

      register :attribute

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
end # Ducktrap
