module Morpher
  class Printer
    include Concord.new(:io, :indent)

    def self.new(io)
      super(io, 0)
    end

    INDENT = '  '.freeze

    def visit(object)
      object.pretty_dump(self)
    end

    def visit_indented(object)
      indented do
        visit(object)
      end
    end

    def attribute(object, name)
      indented do
        puts "#{name}: #{object.public_send(name).inspect}"
      end
    end

    def attributes(object, *names)
      names.each do |name|
        attribute(object, name)
      end
    end

    def indented
      @indent += 1
      yield
      @indent -= 1
    end

    def name(object)
      puts(object.class.to_s)
    end

    def puts(string)
      io.puts(INDENT * indent + string)
      self
    end

  end # Printer
end # Morpher
