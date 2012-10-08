class Mutator
  class Result

    # Namespace for whitelist results
    module Whitelist

      # Result that returns first successful match
      class Multi < Abstract::NAry

      private

        # Calculate result
        #
        # @return [Object]
        #   if successful
        #
        # @return [Undefined]
        #   otherwise
        #
        # @api private
        #
        def result
          results.each do |result|
            return result.output if result.successful?
          end

          Undefined
        end
      end

      # Result that is only successful on one match
      class Single < Abstract::NAry

      private

        # Calculate result
        #
        # @return [Object]
        #   if successful
        #
        # @return [Undefined]
        #   otherwise
        #
        # @api private
        #
        def result
          successful = results.select(&:successful?)

          if successful.length == 1
            successful.first.output
          else
            Undefined
          end
        end

      end
    end
  end
end
