class Mutator

  # Mutator that results in attribute hash
  class Attributes < Abstract::NAry
    RESULT = Result::Attributes

    register :attributes
  end
end

