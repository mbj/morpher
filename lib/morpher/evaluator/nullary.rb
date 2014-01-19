# encoding: UTF-8

module Morpher
  class Evaluator
    # Mixin to define nullary evaluators
    module Nullary

      # Return default successful evaluation
      #
      # @param [Object] input
      #
      # @return [Evaluation]
      #
      # @api private
      #
      def evaluation(input)
        evaluation_success(input, call(input))
      end

      # Hook called when mudule gets included
      #
      # @param [Class, Module] host
      #
      # @return [undefined]
      #
      # @api private
      #
      def self.included(host)
        host.class_eval do
          include Equalizer.new
        end
      end

    private

      # Return evaluation error for input
      #
      # @param [Object] input
      #
      # @return [Evaluation]
      #
      # @api private
      #
      def evaluation_error(input)
        Evaluation.new(
          evaluator: self,
          input:     input,
          output:    Undefined,
          success:   false
        )
      end

      # Return evaluation success for input and output
      #
      # @param [Object] input
      # @param [Object] output
      #
      # @return [Evaluation]
      #
      # @api private
      #
      def evaluation_success(input, output)
        Evaluation.new(
          evaluator: self,
          input:     input,
          output:    output,
          success:   true
        )
      end

    end # Nullary
  end # Evaluator
end # Morpher
