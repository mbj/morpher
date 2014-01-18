module Morpher
  class Evaluator
    class Transformer

      # Too complex hash transformation evaluator
      #
      # FIXME: Should be broken up in better primitives a decompose, compose pair
      #
      # @api private
      #
      class HashTransform < self
        include Concord::Public.new(:body)

        register :hash_transform

        # Test if evaluator is transitive
        #
        # FIXME: Needs to be calculated dynamically
        #
        # @return [true]
        #   if evaluator is transitive
        #
        # @return [false]
        #   otherwise
        #
        # @api private
        #
        def transitive?
          body.all? do |evaluator|
            self.class.transitive_keypair?(evaluator)
          end
        end

        # Test if evaluator is a keypair
        #
        # FIXME: Refactor the need for this away.
        #
        #   This is a side effect from this class is generally to big in sense of SRP.
        #   Must be refactorable away. But dunno now. Still exploring.
        #
        # @param [Evaluator]
        #
        # @api private
        #
        def self.transitive_keypair?(evaluator)
          return false unless evaluator.kind_of?(Block)

          body = evaluator.body

          return false unless body.length == 3

          fetch, operator, dump = body

          fetch.kind_of?(Key::Fetch) && dump.kind_of?(Key::Dump) && operator.transitive?
        end

        # Call evaluator
        #
        # @param [Object] input
        #
        # @return [Object]
        #
        # @api private
        #
        def call(input)
          content = body.map do |node|
            node.call(input)
          end
          Hash[content]
        end

        # Return inverse evaluator
        #
        # @return [HashTransform]
        #
        # @api private
        #
        def inverse
          inverse_body = body.map do |evaluator|
            evaluator.inverse
          end

          self.class.new(inverse_body)
        end

        # Return evaluation
        #
        # @param [Input]
        #
        # @return [Evaluation::Nary]
        #
        # @api private
        #
        def evaluation(input)
          evaluations = body.each_with_object([]) do |evaluator, aggregate|
            evaluation = evaluator.evaluation(input)
            aggregate << evaluation
            return evaluation_error(input, aggregate) unless evaluation.success?
          end

          output = Hash[evaluations.map(&:output)]

          Evaluation::Nary.success(
            evaluator:   self,
            input:       input,
            evaluations: evaluations,
            output:      output,
          )
        end

      private

        # Return evaluation error
        #
        # @return [Object] input
        #
        # @return [Array<Evaluations>] evaluations
        #
        # @api private
        #
        def evaluation_error(input, evaluations)
          Evaluation::Nary.error(
            evaluator:   self,
            input:       input,
            evaluations: evaluations
          )
        end

        # Build evaluator from node
        #
        # @param [Compiler] compiler
        # @param [Node] node
        #
        # @return [Evaluator]
        #
        # @api private
        #
        def self.build(compiler, node)
          body = node.children.map do |child|
            compiler.call(child)
          end
          new(body)
        end

      end # HashTransform
    end # Transformer
  end # Evaluator
end # Morpher
