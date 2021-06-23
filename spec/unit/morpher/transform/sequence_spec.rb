# frozen_string_literal: true

RSpec.describe Morpher::Transform::Sequence do
  subject { described_class.new(steps) }

  let(:steps) do
    [
      hash_transform,
      hash_symbolize
    ]
  end

  let(:hash_transform) do
    Morpher::Transform::Hash.new(optional: [], required: [key_transform])
  end

  let(:key_transform) do
    Morpher::Transform::Hash::Key.new('foo', Morpher::Transform::Boolean.new)
  end

  let(:boolean_transform) do
    Morpher::Transform::Boolean.new
  end

  let(:hash_symbolize) do
    Morpher::Transform::Hash::Symbolize.new
  end

  describe '#call' do
    def apply
      subject.call(input)
    end

    context 'on valid input' do
      let(:input) { { 'foo' => true } }

      it 'returns success' do
        expect(apply).to eql(right(foo: true))
      end
    end

    context 'on invalid input' do
      let(:input) { { 'foo' => 1 } }

      let(:boolean_error) do
        Morpher::Transform::Error.new(
          cause:     nil,
          input:     1,
          message:   'Expected: boolean but got: 1',
          transform: boolean_transform
        )
      end

      let(:key_error) do
        Morpher::Transform::Error.new(
          cause:     boolean_error,
          input:     1,
          message:   nil,
          transform: key_transform
        )
      end

      let(:hash_error) do
        Morpher::Transform::Error.new(
          cause:     key_error,
          input:     input,
          message:   nil,
          transform: hash_transform
        )
      end

      let(:index_error) do
        Morpher::Transform::Error.new(
          cause:     hash_error,
          input:     input,
          message:   nil,
          transform: Morpher::Transform::Index.new(
            index:     0,
            transform: hash_transform
          )
        )
      end

      let(:error) do
        Morpher::Transform::Error.new(
          cause:     index_error,
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

  describe '#seq' do
    subject do
      described_class.new([Morpher::Transform::STRING])
    end

    let(:other) do
      Morpher::Transform::Success.new(:upcase.to_proc)
    end

    it 'build flat sequence' do
      expect(subject.seq(other)).to eql(
        described_class.new(
          [
            Morpher::Transform::STRING,
            other
          ]
        )
      )
    end
  end
end
