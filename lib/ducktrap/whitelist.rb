class Ducktrap

  # Abstract class for whitelisting ducktrap
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
