require 'spec_helper'

describe Ducktrap, '#execute' do
  subject { object.execute(input) }

  let(:object) { class_under_test.new }

  let(:class_under_test) do
    result = self.result
    Class.new(described_class) do
      define_method :run do |input|
        result
      end
    end
  end

  let(:result) { mock('Result', :output => output, :successful? => successful?) }

  let(:input) { mock('Input') }
  let(:error) { mock('Error') }
  let(:output) { mock('Output') }

  context 'when result is successful' do
    let(:successful?) { true }

    it { should be(output) }
  end

  context 'when result is NOT successful' do
    let(:successful?) { false }

    it 'should raise error' do
      expect { subject }.to raise_error(Ducktrap::InvalidInputError.new(result))
    end
  end
end
