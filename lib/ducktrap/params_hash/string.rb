class Ducktrap
  class ParamsHash
    # Base class for ducktraps that load params hashes from string
    class String < self
      include Nullary

      # Base class for params hash results that are deserialized from strings
      class Result < Ducktrap::Result

        # Return deserialized object
        #
        # @return [Object]
        #
        # @api private
        #
        abstract_method :deserialize

      private

        # Process result 
        #
        # @return [Object]
        #
        # @api private
        #
        def process
          object = deserialize
          if object.kind_of?(Hash)
            object
          else
            error
          end
        end
      end
    end
  end
end
