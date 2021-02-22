# frozen_string_literal: true

RSpec.describe Morpher::Transform::Array do
  subject { described_class.new(transform) }

  let(:transform) { Morpher::Transform::Boolean.new }

  describe '#call' do
    def apply
      subject.call(input)
    end

    context 'on array input' do
      context 'empty' do
        let(:input) { [] }

        it 'returns sucess' do
          expect(apply).to eql(right(input))
        end
      end

      context 'valid elements' do
        let(:input) { [true, true] }

        it 'returns sucess' do
          expect(apply).to eql(right(input))
        end
      end

      context 'invalid elements' do
        let(:input) { [true, 1] }

        let(:boolean_error) do
          Morpher::Transform::Error.new(
            cause:     nil,
            input:     1,
            message:   'Expected: boolean but got: 1',
            transform: transform
          )
        end

        let(:index_error) do
          Morpher::Transform::Error.new(
            cause:     boolean_error,
            input:     1,
            message:   nil,
            transform: Morpher::Transform::Index.new(index: 1, transform: transform)
          )
        end

        let(:error) do
          Morpher::Transform::Error.new(
            cause:     index_error,
            input:     input,
            message:   'Failed to coerce array at index: 1',
            transform: subject
          )
        end

        it 'returns failure' do
          expect(apply).to eql(left(error))
        end
      end

      context 'transformed elements' do
        let(:input)     { [{ 'foo' => 'bar' }]                   }
        let(:transform) { Morpher::Transform::Hash::Symbolize.new }

        it 'returns transformed elements' do
          expect(apply).to eql(right([foo: 'bar']))
        end
      end
    end

    context 'on other input' do
      let(:input) { false }

      let(:error) do
        Morpher::Transform::Error.new(
          cause:     nil,
          input:     input,
          message:   'Expected: Array but got: FalseClass',
          transform: subject
        )
      end

      it 'returns failure' do
        expect(apply).to eql(left(error))
      end
    end
  end
end
