class Ducktrap
  # Abstract class for ducktrap that result in fixnum
  class Fixnum < Abstract::Nullary
    include AbstractClass

    # Ducktrap that builds fixnums from strings 
    class String < self
      RESULT = Result::Fixnum::String

      register :fixnum_from_string
    end
  end
end
