class Ducktrap

  # Mixin for NAry ducktraps
  module NAry 

    class MemberError < Ducktrap::Error
      include Equalizer.new(:context, :input, :member)

      def pretty_dump(output = Formatter.new)
        output.puts(self.class.name)
        output = output.indent
        output.puts("input: #{input.inspect}")
        output.puts("member:")
        member.pretty_dump(output.indent)
        output.puts("context:")
        context.pretty_dump(output.indent)
      end

      attr_reader :member

      def initialize(context, input, member)
        @member = member
        super(context, input)
      end
    end

    # Builder for nary ducktraps
    class Builder < Ducktrap::Builder
      
      # Add ducktrap argument
      #
      # @param [Ducktrap] ducktrap
      #
      # @return [self]
      #
      def add(ducktrap)
        body << ducktrap
        self
      end

      # Hook called when method is missing
      #
      # @return [Object]
      #
      # @api private
      #
      def method_missing(name, *arguments, &block)
        builder = DSL.lookup(name) { super }
        add(builder.build(*arguments, &block))
      end

      # Return build instance
      #
      # @return [Object]
      #
      # @api private
      #
      def object
        @klass.new(body)
      end
      memoize :object

      attr_reader :body

      # Initialize object
      #
      # @param [Class] klass
      #   the klass to build
      #
      # @param [Enumerable<Object>] *arguments
      #   the arguments to pass into constructor
      #
      # @api private
      #
      def initialize(klass, body = [])
        @body = body
        super(klass)
      end
    end

    module ClassMethods
      def build(*arguments, &block)
        Builder.new(self, *arguments, &block).object
      end
    end

    module InstanceMethods
      def pretty_dump(output=Formatter.new)
        output.puts("#{self.class.name}:")
        output = output.indent
        output.puts("body:")
        output = output.indent
        body.each do |member|
          member.pretty_dump(output)
        end
        self
      end

      # Run ducktrap on input
      #
      # @param [Object] input
      #
      # @return [Result]
      #
      # @api private
      #
      def run(input)
        result_klass.new(self, input, body)
      end

      def inverse_body
        body.map(&:inverse).reverse
      end

      # Return body 
      #
      # @return [Enumerable<Ducktrap>]
      #
      # @api private
      #
      attr_reader :body

    private

      # Initialize object
      #
      # @param [Enumerable<Ducktrap>] body
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(body=[])
        @body = body
        super()
      end
    end

    def self.included(scope)
      super
      scope.extend(ClassMethods)
      scope.send(:include, InstanceMethods)
      scope.send(:include, Equalizer.new(:body))
      self
    end
  end

  module NAry
    # Base class for nary results
    class Result < Ducktrap::Result

      # Return body
      #
      # @return [Enumerable<Ducktrap>]
      #
      # @api private
      #
      attr_reader :body

    private

      # Initialize object
      #
      # @param [Object] input
      # @param [Enumerable<Ducktrap>] body
      #
      # @return [undefined]
      #
      # @api private
      #
      def initialize(context, input, body)
        @body = body
        super(context, input)
      end
    end
  end
end
