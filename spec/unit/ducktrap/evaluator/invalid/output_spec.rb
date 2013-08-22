require 'spec_helper'

describe Ducktrap::Evaluator::Invalid, '#output' do
  let(:object) { described_class.new(context, input) }

  let(:context) { double('Context') }
  let(:input)   { double('Input')   }

  subject { object.output }

  it { should eql(Ducktrap::Error.new(context, input)) }

  it_should_behave_like 'an idempotent method'
end
