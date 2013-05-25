require 'spec_helper'

describe Ducktrap::Node::Primitive, '#run' do
  let(:object) { described_class.new(primitive) }

  let(:primitive) { String }

  subject { object.run(input) }

  context 'when input is kind of primitive' do
    let(:input) { String.new }
    it { should eql(Ducktrap::Evaluator::Noop.new(object, input)) }
  end

  context 'when input is NOT kind of primitive' do
    let(:input) { [] }
    it { should eql(Ducktrap::Evaluator::Invalid.new(object, input)) }
  end
end
