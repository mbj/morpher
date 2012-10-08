class Transformator
  class Params

    # Abstract base class for transformators with rack env as input
    class Rack < self
      include AbstractClass

    private

      alias_method :env, :input
      private :env
    end
  end
end
