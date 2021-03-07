# frozen_string_literal: true

module Morpher
  # Generator for struct a-like wrappers
  class Record < Module
    include Concord.new(:attributes)

    # rubocop:disable Metrics/MethodLength
    def included(host)
      attributes     = attributes()
      keys_transform = keys_transform()

      host.class_eval do
        include Adamantium::Flat, Anima.new(*attributes.keys)

        const_set(
          :TRANSFORM,
          Transform::Sequence.new(
            [
              Transform::Primitive.new(Hash),
              Transform::Hash::Symbolize.new,
              Transform::Hash.new(required: keys_transform, optional: []),
              Transform::Success.new(public_method(:new))
            ]
          )
        )
      end
    end
  # rubocop:enable Metrics/MethodLength

  private

    def keys_transform
      attributes.map do |name, transform|
        Transform::Hash::Key.new(name, transform)
      end
    end
  end # Record
end # Morpher
