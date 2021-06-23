# frozen_string_literal: true

RSpec.describe Morpher::Transform do
  describe '#seq' do
    subject do
      Morpher::Transform::STRING
    end

    let(:other) do
      Morpher::Transform::Success.new(:upcase.to_proc)
    end

    it 'returns sequence' do
      expect(subject.seq(other)).to eql(
        Morpher::Transform::Sequence.new([subject, other])
      )
    end
  end
end
