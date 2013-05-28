module Ducktrap
  class Node
    # Node for disjunct input processing
    class Disjunction < self
      include Nary
    end
  end
end
