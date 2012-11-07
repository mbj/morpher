class Ducktrap
  # Abstract base class for builders
  class Builder
    include Adamantium::Flat, AbstractClass

    attr_reader :klass

  private

    # Initialize object
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
  end
end
