class Mutator
  # Abstract class for mutator that result in fixnum
  class Fixnum < Abstract::Input
    include AbstractClass

    # Mutator that builds fixnums from strings 
    class String < self
      RESULT = Result::Fixnum::String

      register :fixnum_from_string
    end
  end
end
