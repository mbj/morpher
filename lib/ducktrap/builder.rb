module Ducktrap
  # Abstract base class for builders
  class Builder
    include Adamantium::Flat, AbstractType, Equalizer.new(:klass)

    # Return class to build
    #
    # @return [Class:Ducktrap]
    #
    # @api private
    #
    attr_reader :klass

  private

    # Initialize object
    #
    # @param [Class:Ducktrap] klass
    #
    # @return [undefined]
    #
    # @api private
    #
    def initialize(klass, &block)
      @klass = klass
      return unless block

      if block.arity.zero?
        instance_eval(&block)
      else
        block.call(self)
      end
    end

  end # Builder
end # Ducktrap
