# frozen_string_literal: true

RSpec.describe Morpher::Transform::Maybe do
  subject { described_class.new(transform) }

  let(:transform) { Morpher::Transform::STRING }

  describe '#call' do
    def apply
      subject.call(input)
    end

    context 'on nil input' do
      let(:input) { nil }

      it 'returns sucess' do
        expect(apply).to eql(right(nil))
      end
    end

    context 'on non nil input' do
      context 'on input valid for innner transform' do
        let(:input) { 'some-string' }

        it 'returns sucess' do
          expect(apply).to eql(right('some-string'))
        end
      end

      context 'on input invalud for inner transform' do
        let(:input) { 1 }

        let(:error) do
          Morpher::Transform::Error.new(
            cause:     transform.call(input).from_left,
            input:     input,
            message:   nil,
            transform: subject
          )
        end

        it 'returns failure' do
          expect(apply).to eql(left(error))
        end
      end
    end
  end
end
