# frozen_string_literal: true

RSpec.describe Morpher::Transform do
  describe '#array' do
    subject do
      Morpher::Transform::STRING
    end

    it 'returns array' do
      expect(subject.array).to eql(
        Morpher::Transform::Array.new(subject)
      )
    end
  end

  describe '#maybe' do
    subject do
      Morpher::Transform::STRING
    end

    it 'returns maybe' do
      expect(subject.maybe).to eql(
        Morpher::Transform::Maybe.new(subject)
      )
    end
  end

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
