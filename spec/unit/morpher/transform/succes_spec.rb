# frozen_string_literal: true

RSpec.describe Morpher::Transform::Success do
  subject { described_class.new(block) }

  let(:block) { ->(value) { value.to_s } }

  describe '#call' do
    def apply
      subject.call(input)
    end

    context 'on any input' do
      let(:input) { 100 }

      it 'returns sucess on block output' do
        expect(apply).to eql(right('100'))
      end
    end
  end
end
