class Transformator

  # Abstract base class for transformators to params
  #
  # Params are returned after parsing inputs like http post or get, json or yaml.
  # A possible nested hash of arbitrary keys and types. The structure can but should not be 
  # used for later processing as the structure of the data is usunally not validated in any kind.
  #
  # Params could be viewed of unvalidated structure of data. 
  #
  class Params < self
    include AbstractClass
    extend Builder::Noop
  end

end
