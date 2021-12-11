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

  describe '#to_proc' do
    subject do
      Morpher::Transform::STRING
    end

    it 'returns proc' do
      expect(subject.to_proc).to be_instance_of(Proc)
    end

    it 'executes #call when evaluated' do
      aggregate_failures do
        expect(subject.to_proc.call('a').from_right).to be('a')
        expect(subject.to_proc.call(1).lmap(&:compact_message).from_left).to eql(
          'String: Expected: String but got: Integer'
        )
      end
    end
  end
end
