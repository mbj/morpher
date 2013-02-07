class Ducktrap
  # Abstract base class for builders
  class Builder
    include Adamantium::Flat, AbstractType

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

      if block.arity == 1
        block.call(self)
      else
        instance_eval(&block)
      end
    end
  end
end
