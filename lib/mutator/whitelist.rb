class Mutator

  # Abstract class for whitelisting mutator
  class Whitelist < Abstract::NAry
    include AbstractClass

    # Whitelist that pics first successful mutation
    class Multi < self
      RESULT = Result::Whitelist::Multi

      register :whitelist
    end

    # Whitelist that allows one successful mutation
    class Single < self
      RESULT = Result::Whitelist::Single

      register :whitelist_strict
    end
  end

end
