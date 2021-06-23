# frozen_string_literal: true

RSpec.describe Morpher::Record do
  describe '.new' do
    def apply
      described_class.new(**attributes)
    end

    let(:fields) { { foo: Morpher::Transform::STRING } }

    context 'on absent :optional' do
      let(:attributes) { { required: fields } }

      it 'defaults to empty optional' do
        expect(apply.to_h).to eql(
          optional: {},
          required: fields
        )
      end
    end

    context 'on absent :required' do
      let(:attributes) { { optional: fields } }

      it 'defaults to empty optional' do
        expect(apply.to_h).to eql(
          optional: fields,
          required: {}
        )
      end
    end

    context 'on present :required and :optional' do
      let(:attributes) do
        {
          optional: { foo: Morpher::Transform::STRING },
          required: { bar: Morpher::Transform::STRING }
        }
      end

      it 'does not apply defaults' do
        expect(apply.to_h).to eql(attributes)
      end
    end
  end

  describe '#included' do
    define_method(:apply) do
      instance = instance()

      host.class_eval { include instance }
    end

    let(:attributes)     { { a: 'foo', b: 10, c: nil } }
    let(:host)           { Class.new                   }
    let(:host_instance)  { host.new(attributes)        }

    let(:instance) do
      described_class.new(
        required: required_transform,
        optional: optional_transform
      )
    end

    let(:required_transform) do
      {
        a: Morpher::Transform::Primitive.new(String),
        b: Morpher::Transform::Primitive.new(Integer)
      }
    end

    let(:optional_transform) do
      {
        c: Morpher::Transform::Boolean.new
      }
    end

    let(:expected_required_keys_transform) do
      [
        Morpher::Transform::Hash::Key.new(:a, required_transform.fetch(:a)),
        Morpher::Transform::Hash::Key.new(:b, required_transform.fetch(:b))
      ]
    end

    let(:expected_optional_keys_transform) do
      [
        Morpher::Transform::Hash::Key.new(:c, optional_transform.fetch(:c))
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
            Morpher::Transform::Hash.new(
              required: expected_required_keys_transform,
              optional: expected_optional_keys_transform
            ),
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
