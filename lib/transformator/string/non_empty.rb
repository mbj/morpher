class Transformator

  class String

    # Transformator for non empty string
    #
    # This is usefull in cases a empty string should be interpreted as non present input.
    # This situartion can occur when submitting html forms.
    #
    class NonEmpty < self

    private
      # Return loaded value
      #
      # @return [String]
      #   if input is non empty
      #
      # @return [nil]
      #   if input is empty
      #
      # @return [Undefined]
      #   if input is not a string
      #
      # @api private
      #   
      def load
        return Undefined unless string?

        string = input

        if string.empty?
          nil
        else
          string
        end
      end

    end
  end
end
