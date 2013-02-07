class Ducktrap
  # A value with a name
  class NamedValue
    include Composition.new(:name, :value)
  end
end
