require 'spec_helper'

describe Ducktrap::Node::Anima::Dump::Evaluator, '#output' do
  let(:object)  { described_class.new(context, input) }
  let(:model) do
    Class.new do
      include Anima.new(:foo)
    end
  end
  let(:context) { mock('Context', :model => model)    }
  let(:input) { model.new(:foo => :bar) }

  subject { object.output }

  it { should eql(:foo => :bar) }

  it_should_behave_like 'an idempotent method'
end
