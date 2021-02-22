# frozen_string_literal: true

RSpec.describe Morpher::Transform::Boolean do
  subject { described_class.new }

  describe '#call' do
    def apply
      subject.call(input)
    end

    context 'on true' do
      let(:input) { true }

      it 'returns sucess' do
        expect(apply).to eql(right(input))
      end
    end

    context 'on false' do
      let(:input) { false }

      it 'returns sucess' do
        expect(apply).to eql(right(input))
      end
    end

    context 'on nil input' do
      let(:input) { nil }

      let(:error) do
        Morpher::Transform::Error.new(
          cause:     nil,
          input:     input,
          message:   'Expected: boolean but got: nil',
          transform: subject
        )
      end

      it 'returns failure' do
        expect(apply).to eql(left(error))
      end
    end

    context 'on truthy input' do
      let(:input) { '' }

      let(:error) do
        Morpher::Transform::Error.new(
          cause:     nil,
          input:     input,
          message:   'Expected: boolean but got: ""',
          transform: subject
        )
      end

      it 'returns failure' do
        expect(apply).to eql(left(error))
      end
    end
  end
end
