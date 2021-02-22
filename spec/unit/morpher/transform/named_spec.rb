# frozen_string_literal: true

RSpec.describe Morpher::Transform::Named do
  subject { described_class.new(name, transform) }

  let(:name)      { 'transform-name'               }
  let(:transform) { Morpher::Transform::Boolean.new }

  describe '#slug' do
    def apply
      subject.slug
    end

    it 'returns name' do
      expect(apply).to be(name)
    end
  end

  describe '#call' do
    def apply
      subject.call(input)
    end

    context 'on valid input' do
      let(:input) { true }

      it 'returns sucess' do
        expect(apply).to eql(right(input))
      end
    end

    context 'on invalid input' do
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
