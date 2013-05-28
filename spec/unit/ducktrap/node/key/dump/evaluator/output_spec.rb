require 'spec_helper'

describe Ducktrap::Node::Key::Dump::Evaluator, '#output' do

  let(:object)  { described_class.new(context, input)               }
  let(:context) { mock('Context', :operand => operand, :key => key) }
  let(:operand) { Ducktrap::Node::Noop.instance }

  subject { object.output }

  let(:key)   { mock('Key', :frozen? => true)   }
  let(:value) { mock('Value', :frozen? => true) }
  
  let(:input) { value }

  context 'when operand does NOT modify value' do

    it { should eql({ key => value}) }
    it_should_behave_like 'an idempotent method'

  end

  context 'when operand does modify value' do
    let(:operand) { Ducktrap::Node::Static.new(:forward, :inversE) }

    it { should eql({ key => :forward}) }
    it_should_behave_like 'an idempotent method'

  end

  context 'when operand fails' do

    let(:operand) { Ducktrap::Node::Invalid.instance }

    it { should eql(Ducktrap::Error.new(operand.run(value), input)) }
  end
end
