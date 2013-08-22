require 'spec_helper'

describe Ducktrap::Node::Map::Evaluator, '#output' do
  let(:object) { described_class.new(context, input) }

  let(:context) { double('Context', :operand => operand) }
  let(:input)   { [:foo, :bar ] }

  subject { object.output }

  context 'success' do
    let(:operand) { Ducktrap::Node::Noop.instance }

    it { should eql([:foo, :bar]) }
  end

  context 'error' do
    let(:operand) { Ducktrap::Node::Invalid.instance }

    it { should eql(Ducktrap::Error.new(operand.call(:foo), input)) }
  end
end
