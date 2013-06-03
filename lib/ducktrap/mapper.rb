module Ducktrap
  # An object holding references to two inverse ducktraps
  class Mapper
    include Concord::Public.new(:loader, :dumper)

    # Build mapper
    #
    # @return [Mapper]
    #
    # @api private
    #
    def self.build(&block)
      Builder.new(self, &block).object
    end

    # Builder for mapper
    class Builder < Ducktrap::Builder

      # Capture loader block
      #
      # @return [self]
      #
      # @api private
      #
      def loader(&block)
        @loader = Ducktrap.build(&block)
        @dumper ||= @loader.inverse
        self
      end

      # Capture dumper block
      #
      # @return [self]
      #
      # @api private
      #
      def dumper(&block)
        @dumper = Ducktrap.build(&block)
        @loader ||= @dumper.inverse
        self
      end

      # Return mapper
      #
      # @return [Mapper]
      #
      # @api private
      #
      def object
        unless @loader or @dumper
          raise 'Did not specify loader or dumper or both'
        end

        klass.new(@loader, @dumper)
      end

    end # Builder
  end # Mapper
end # Ducktrap
