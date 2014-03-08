module Morpher
  class Compiler
    class Evaluator
      # Emitter for evaluators
      class Emitter < Compiler::Emitter
        include Registry, Concord.new(:compiler, :evaluator_klass, :node)

        # Return output
        #
        # @return [Evaluator]
        #
        # @api private
        #
        def output
          evaluator
        end
        memoize :output

        # Return evaluator
        #
        # @return [Evaluator]
        #
        # @api private
        #
        abstract_method :evaluator
        private :evaluator

      private

        # Emitter for nullary non parameterized evaluators
        class Nullary < self
          register Morpher::Evaluator::Nullary

        private

          # Return output
          #
          # @return [Evaluator]
          #
          # @api private
          #
          def evaluator
            evaluator_klass.new
          end

          # Emitter for nullary parameterized evaluators
          class Parameterized < self
            register Morpher::Evaluator::Nullary::Parameterized

            children :param

          private

            # Return output
            #
            # @return [Evaluator]
            #
            # @api private
            #
            def evaluator
              evaluator_klass.new(param)
            end

          end # Paramterized
        end # Nullary

        # Emitter for unary evaluators
        class Unary < self
          register Morpher::Evaluator::Unary
          children :operand

        private

          # Return evaluator
          #
          # @return [Evaluator]
          #
          # @api private
          #
          def evaluator
            evaluator_klass.new(compiler.call(operand))
          end

        end # Unary

        # Emitter for unary evaluators
        class Binary < self
          register Morpher::Evaluator::Binary
          children :left, :right

        private

          # Return evaluator
          #
          # @return [Evaluator]
          #
          # @api private
          #
          def evaluator
            evaluator_klass.new(
              compiler.call(left),
              compiler.call(right)
            )
          end

        end # Unary

        # Emitter for nary evaluators
        class Nary < self
          register Morpher::Evaluator::Nary

        private

          # Return evaluator
          #
          # @return [Evaluator]
          #
          # @api private
          #
          def evaluator
            evaluator_klass.new(children.map(&compiler.method(:call)))
          end

        end # Nary

      end # Emitter
    end # Evaluator
  end # Compiler
end # Morpher
