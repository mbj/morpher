class Mutator
  class Result
    class Attribute 

      # Mutator from params to attribute
      #
      # TODO:
      #
      #  * Split in a mutator results that fail when 
      #    params do not contain attribute and one
      #    that defaults to something (or nil)
      #
      class Params < self

        default_equalizer
        
      private

        # Return exracted input
        #
        # @return [Object]
        #   if value is present in params
        #
        # @return [nil]
        #   otherwise
        #
        def inner_input
          input[key]
        end
        memoize :inner_input

        # Return key as tring
        #
        # @return [String]
        #
        # @api private
        # 
        def key
          name.to_s
        end
        memoize :key
      end
    end
  end
end
