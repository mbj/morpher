# frozen_string_literal: true

RSpec.describe Morpher::Transform::Index do
  subject { described_class.new(index: index, transform: transform) }

  let(:index)     { 1                              }
  let(:transform) { Morpher::Transform::Boolean.new }

  describe '#slug' do
    def apply
      subject.slug
    end

    it 'retursn expected value' do
      expect(apply).to eql('1')
    end

    it 'returns frozen value' do
      expect(apply.frozen?).to be(true)
    end

    it 'returns idempotent value' do
      expect(apply).to be(apply)
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

    context 'on nvalid input' do
      let(:input) { 1 }

      let(:boolean_error) do
        Morpher::Transform::Error.new(
          cause:     nil,
          input:     input,
          message:   'Expected: boolean but got: 1',
          transform: transform
        )
      end

      let(:error) do
        Morpher::Transform::Error.new(
          cause:     boolean_error,
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

  describe '.wrap' do
    def apply
      described_class.wrap(error, index)
    end

    let(:error) do
      Morpher::Transform::Error.new(
        cause:     :nil,
        input:     1,
        message:   nil,
        transform: transform
      )
    end

    it 'returns wrapped error' do
      expect(apply).to eql(
        Morpher::Transform::Error.new(
          cause:     error,
          input:     1,
          message:   nil,
          transform: described_class.new(index: index, transform: transform)
        )
      )
    end
  end
end
