# frozen_string_literal: true

RSpec.describe Morpher::Transform::Hash do
  subject { described_class.new(attributes) }

  let(:required) { []                                       }
  let(:optional) { []                                       }
  let(:symbol)   { Morpher::Transform::Primitive.new(Symbol) }

  let(:attributes) do
    {
      required: required,
      optional: optional
    }
  end

  describe '#call' do
    def apply
      subject.call(input)
    end

    context 'on Hash input' do
      context 'empty' do
        let(:input) { {} }

        it 'returns sucess' do
          expect(apply).to eql(right(input))
        end
      end

      context 'missing key' do
        let(:input)    { {}                                       }
        let(:required) { [described_class::Key.new(:foo, symbol)] }

        let(:error) do
          Morpher::Transform::Error.new(
            cause:     nil,
            input:     input,
            message:   'Missing keys: [:foo], Unexpected keys: []',
            transform: subject
          )
        end

        it 'returns error' do
          expect(apply).to eql(left(error))
        end
      end

      context 'extra key' do
        let(:input) { { foo: :bar } }

        let(:error) do
          Morpher::Transform::Error.new(
            cause:     nil,
            input:     input,
            message:   'Missing keys: [], Unexpected keys: [:foo]',
            transform: subject
          )
        end

        it 'returns error' do
          expect(apply).to eql(left(error))
        end
      end

      context 'using required' do
        let(:input)    { { foo: :bar }                            }
        let(:required) { [described_class::Key.new(:foo, symbol)] }

        it 'returns success' do
          expect(apply).to eql(right(input))
        end
      end

      context 'using optional' do
        let(:optional) { [described_class::Key.new(:foo, symbol)] }

        context 'not providing the optional key' do
          let(:input) { {} }

          it 'returns success' do
            expect(apply).to eql(right(input))
          end
        end

        context 'providing the optional key' do
          let(:input) { { foo: :bar } }

          it 'returns success' do
            expect(apply).to eql(right(input))
          end
        end
      end

      shared_examples 'key transform error' do
        let(:innermost_error) do
          Morpher::Transform::Error.new(
            cause:     nil,
            input:     'bar',
            message:   'Expected: Symbol but got: String',
            transform: symbol
          )
        end

        let(:inner_error) do
          Morpher::Transform::Error.new(
            cause:     innermost_error,
            input:     'bar',
            message:   nil,
            transform: key_transform
          )
        end

        let(:error) do
          Morpher::Transform::Error.new(
            cause:     inner_error,
            input:     input,
            message:   nil,
            transform: subject
          )
        end

        it 'returns failure' do
          expect(apply).to eql(left(error))
        end
      end

      context 'key transform error' do
        let(:input) { { foo: 'bar' } }

        let(:key_transform) { described_class::Key.new(:foo, symbol) }

        context 'on optional key' do
          let(:optional) { [key_transform] }

          include_examples 'key transform error'
        end

        context 'on required key' do
          let(:required) { [key_transform] }

          include_examples 'key transform error'
        end
      end
    end

    context 'on other input' do
      let(:input) { [] }

      let(:error) do
        Morpher::Transform::Error.new(
          cause:     nil,
          input:     input,
          message:   'Expected: Hash but got: Array',
          transform: subject
        )
      end

      it 'returns failure' do
        expect(apply).to eql(left(error))
      end
    end
  end
end

RSpec.describe Morpher::Transform::Hash::Symbolize do
  subject { described_class.new }

  describe '#call' do
    def apply
      subject.call(input)
    end

    context 'on all string keys' do
      let(:input) { { 'foo' => 'bar' } }

      it 'returns success' do
        expect(apply).to eql(right(foo: 'bar'))
      end
    end

    context 'on non string keys' do
      let(:error) do
        Morpher::Transform::Error.new(
          cause:     nil,
          input:     input,
          message:   'Found non string key in input',
          transform: subject
        )
      end

      context 'one non string key' do
        let(:input) { { 1 => 'bar' } }

        it 'returns error' do
          expect(apply).to eql(left(error))
        end
      end

      context 'one non string key next to string key' do
        let(:input) { { 1 => 'bar', 'foo' => 'baz' } }

        it 'returns error' do
          expect(apply).to eql(left(error))
        end
      end
    end
  end
end

RSpec.describe Morpher::Transform::Hash::Key do
  subject { described_class.new(:foo, boolean) }

  let(:boolean) { Morpher::Transform::Boolean.new }

  describe '#slug' do
    def apply
      subject.slug
    end

    it 'returns expected slug' do
      expect(apply).to eql('[:foo]')
    end
  end

  describe '#call' do
    def apply
      subject.call(input)
    end

    context 'on valid input' do
      let(:input) { true }

      it 'returns success' do
        expect(apply).to eql(right(true))
      end
    end

    context 'on invalid input' do
      let(:input) { 1 }

      let(:inner_error) do
        Morpher::Transform::Error.new(
          cause:     nil,
          input:     1,
          message:   'Expected: boolean but got: 1',
          transform: boolean
        )
      end

      let(:error) do
        Morpher::Transform::Error.new(
          cause:     inner_error,
          input:     1,
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
