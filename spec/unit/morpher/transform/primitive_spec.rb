# frozen_string_literal: true

RSpec.describe Morpher::Transform::Primitive do
  subject { described_class.new(primitive) }

  let(:primitive) { String }

  describe '#slug' do
    def apply
      subject.slug
    end

    it 'returns strigified primitive' do
      expect(apply).to eql('String')
    end

    it 'is idempotent' do
      expect(apply).to be(apply)
    end

    it 'is frozen' do
      expect(apply.frozen?).to be(true)
    end
  end

  describe '#call' do
    def apply
      subject.call(input)
    end

    context 'on string input' do
      let(:input) { 'some-string' }

      it 'returns sucess' do
        expect(apply).to eql(right(input))
      end
    end

    context 'on other input' do
      let(:input) { 1 }

      let(:error) do
        Morpher::Transform::Error.new(
          cause:     nil,
          input:     input,
          message:   'Expected: String but got: Integer',
          transform: subject
        )
      end

      it 'returns failure' do
        expect(apply).to eql(left(error))
      end
    end
  end
end
