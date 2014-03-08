# encoding: UTF-8

module Morpher
  class Evaluator
    class Transformer
      # Abstract namespace class for transformers from/to domain
      class Domain < self
        include AbstractType, Nullary::Parameterized, Transitive
      end # Domain
    end # Transformer
  end # Evaluator
end # Morpher
