# frozen_string_literal: true

module Morpher
  # Generator for struct a-like wrappers
  class Record < Module
    include Anima.new(:required, :optional)

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    def included(host)
      optional           = optional()
      optional_transform = transform(optional)
      required           = required()
      required_transform = transform(required)

      host.class_eval do
        include Adamantium::Flat, Anima.new(*(required.keys + optional.keys))

        const_set(
          :TRANSFORM,
          Transform::Sequence.new(
            [
              Transform::Primitive.new(Hash),
              Transform::Hash::Symbolize.new,
              Transform::Hash.new(
                required: required_transform,
                optional: optional_transform
              ),
              Transform::Success.new(public_method(:new))
            ]
          )
        )
      end
    end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  private

    def transform(attributes)
      attributes.map do |name, transform|
        Transform::Hash::Key.new(name, transform)
      end
    end
  end # Record
end # Morpher
