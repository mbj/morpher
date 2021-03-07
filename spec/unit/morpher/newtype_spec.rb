# frozen_string_literal: true

RSpec.describe Morpher::Newtype do
  describe '#included' do
    define_method(:apply) do
      instance = instance()

      host.class_eval { include instance }
    end

    let(:host)           { Class.new                                 }
    let(:host_instance)  { host.new(value)                           }
    let(:instance)       { described_class.new(transform)            }
    let(:transform)      { Morpher::Transform::Primitive.new(String) }
    let(:value)          { instance_double(Object, :value)           }

    it 'creates public #value method on host instances' do
      apply

      expect(host_instance.value).to be(value)
    end

    it 'includes Adamantium::Flat into the host' do
      apply

      expect(host.ancestors).to include(Adamantium::Flat)

      expect(host_instance.frozen?).to be(true)
    end

    it 'allows to equalize on host instances' do
      apply

      expect(host_instance.eql?(host.new(value))).to be(true)
    end

    it 'creates the expected TRANSFORMER constant on the host' do
      apply

      expect(host::TRANSFORM).to eql(
        Morpher::Transform::Sequence.new(
          [
            transform,
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
