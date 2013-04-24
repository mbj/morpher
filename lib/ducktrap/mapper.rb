module Ducktrap
  # An object holding references to two inverse ducktraps
  class Mapper
    include Concord.new(:loader, :dumper)

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
        @loader = block
        self
      end

      # Capture dumper block
      #
      # @return [self]
      #
      # @api private
      #
      def dumper(&block)
        @dumper = block
        self
      end

      # Return mapper
      #
      # @return [Mapper]
      #
      # @api private
      #
      def object
        unless @dumper or @loader
          raise 'Did not specify loader or dumper or both'
        end

        klass.new(loader_instance, dumper_instance)
      end

    private

      # Return loader instance
      #
      # @return [Ducktrap::Node]
      #
      # @api private
      #
      def loader_instance
        unless @loader
          return dumper_instance.inverse
        end
        Ducktrap.build(&@loader)
      end

      # Return inverse block
      #
      # @return [Proc]
      #
      # @api private
      #
      def dumper_instance
        unless @dumper
          return loader_instance.inverse
        end
        Ducktrap.build(&@dumper)
      end

    end
  end
end
