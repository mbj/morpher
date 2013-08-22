require 'spec_helper'

describe Ducktrap::Evaluator::Noop, '#output' do
  let(:object) { described_class.new(context, input) }

  subject { object.output }

  let(:context) { double('Context') }
  let(:input)   { double('Input') }

  it { should be(input) }

  it_should_behave_like 'an idempotent method'
end
