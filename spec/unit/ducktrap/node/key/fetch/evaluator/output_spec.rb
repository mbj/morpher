require 'spec_helper'

describe Ducktrap::Node::Key::Fetch::Evaluator, '#output' do

  let(:object)  { described_class.new(context, input)               }
  let(:context) { mock('Context', :operand => operand, :key => key) }
  let(:operand) { Ducktrap::Node::Noop.instance }

  subject { object.output }

  let(:key)   { mock('Key', :frozen? => true)   }
  let(:value) { mock('Value', :frozen? => true) }


  context 'when key is present' do
    let(:input) { { key => value } }

    context 'and operand does NOT modify value' do

      it { should be(value) }
      it_should_behave_like 'an idempotent method'

    end

    context 'and operand does modify value' do
      let(:operand) { Ducktrap::Node::Static.new(:forward, :inversE) }

      it { should be(:forward) }
      it_should_behave_like 'an idempotent method'

    end

    context 'and operand fails' do

      let(:operand) { Ducktrap::Node::Invalid.instance }

      it { should eql(Ducktrap::Error.new(operand.run(value), input)) }
    end
  end

  context 'when key is NOT present' do
    let(:input) { {} }

    it { should eql(Ducktrap::Error.new(context, input)) }

    it_should_behave_like 'an idempotent method'
  end
end
