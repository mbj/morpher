class Mutator
  class Result
    class Params

      # Abstract base class for mutation results with rack env as input
      class Rack < self
        include AbstractClass

      private

        alias_method :env, :input
        private :env
      end
    end
  end
end
