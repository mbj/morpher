require 'spec_helper'

describe Ducktrap::Node::Anima::Load::Evaluator, '#output' do

  let(:object)  { described_class.new(context, input) }

  let(:model) do
    Class.new do
      include Anima.new(:foo)
    end
  end

  let(:context) { double('Context', :model => model) }

  subject { object.output }

  context 'with compatible input' do
    let(:input) { { :foo => :bar} }

    it { should eql(model.new(:foo => :bar)) }

    it_should_behave_like 'an idempotent method'
  end

  context 'with incompatible input' do
    let(:input) { {} }

    specify do
      error = subject
      should eql(Ducktrap::Error::Exception.new(context, input, error.exception))
    end

    it_should_behave_like 'an idempotent method'
  end
end
