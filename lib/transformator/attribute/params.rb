class Transformator
  class Attribute 

    # Transformator to attributes from params
    #
    # TODO:
    #
    #  * Split in a transformator that fails when 
    #    params do not contain attribute and one
    #    that defaults to something
    #
    class Params < self
      
      register :attribute_from_params

    private

      # Load attribute from input
      #
      # @return [Object]
      #   if value is present in params
      #
      # @return [nil]
      #   otherwise
      #
      def load
        input[key]
      end

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
