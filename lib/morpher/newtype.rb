# frozen_string_literal: true

module Morpher
  # Generator for primitive wrappers
  class Newtype < Module
    include Concord.new(:transform)

    # rubocop:disable Metrics/MethodLength
    def included(host)
      transform = transform()

      host.class_eval do
        include Adamantium::Flat, Concord::Public.new(:value)

        const_set(
          :TRANSFORM,
          Transform::Sequence.new(
            [
              transform,
              Transform::Success.new(public_method(:new))
            ]
          )
        )
      end
    end
    # rubocop:enable Metrics/MethodLength
  end
end
