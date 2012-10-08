class Mutator
  # Abstract mutator with params as result
  class Params < Abstract::Input
    include AbstractClass 

    class URLEncoded < self
      RESULT = Result::Params::URLEncoded
      register :params_from_url_encoded
    end
  end
end
