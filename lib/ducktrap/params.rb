class Ducktrap
  # Abstract ducktrap with params as result
  class Params < Abstract::Nullary
    include AbstractClass 

    class URLEncoded < self
      RESULT = Result::Params::URLEncoded
      register :params_from_url_encoded
    end
  end
end
