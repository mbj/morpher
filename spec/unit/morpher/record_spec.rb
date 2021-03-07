# frozen_string_literal: true

RSpec.describe Morpher::Record do
  describe '#included' do
    define_method(:apply) do
      instance = instance()

      host.class_eval { include instance }
    end

    let(:host)           { Class.new                                 }
    let(:host_instance)  { host.new(attributes)                      }
    let(:instance)       { described_class.new(attributes_transform) }
    let(:attributes)     { { a: 'foo', b: 10 }                       }

    let(:attributes_transform) do
      {
        a: Morpher::Transform::Primitive.new(String),
        b: Morpher::Transform::Primitive.new(Integer)
      }
    end

    let(:expected_keys_transform) do
      [
        Morpher::Transform::Hash::Key.new(:a, attributes_transform.fetch(:a)),
        Morpher::Transform::Hash::Key.new(:b, attributes_transform.fetch(:b))
      ]
    end

    it 'creates public #to_h method on host instances' do
      apply

      expect(host_instance.to_h).to eql(attributes)
    end

    it 'includes Adamantium::Flat into the host' do
      apply

      expect(host.ancestors).to include(Adamantium::Flat)

      expect(host_instance.frozen?).to be(true)
    end

    it 'allows to equalize on host instances' do
      apply

      expect(host_instance.eql?(host.new(attributes))).to be(true)
    end

    it 'creates the expected TRANSFORMER constant on the host' do
      apply

      expect(host::TRANSFORM).to eql(
        Morpher::Transform::Sequence.new(
          [
            Morpher::Transform::Primitive.new(Hash),
            Morpher::Transform::Hash::Symbolize.new,
            Morpher::Transform::Hash.new(required: expected_keys_transform, optional: []),
            Morpher::Transform::Success.new(host.method(:new))
          ]
        )
      )
    end

    it 'does not create the #value method on the instance' do
      apply

      expect(instance.instance_methods).to_not include(:value)
    end

    it 'does not create the TRANSFORMER constant on the instance' do
      apply

      expect(instance.constants).to_not include(:TRANSFORMER)
    end
  end
end
