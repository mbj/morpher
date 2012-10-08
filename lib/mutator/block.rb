class Mutator

  # Mutator that returns last result of a chain and stops on first failure
  class Block < Abstract::NAry
    RESULT = Result::Block

    register :block
  end
end
