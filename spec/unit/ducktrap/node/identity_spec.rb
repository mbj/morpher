require 'spec_helper'

describe Ducktrap::Node::Identity do

  let(:object) { described_class.instance }

  describe '#call' do
    subject { object.call(input) }

    let(:input) { double('Input') }

    it { should eql(Ducktrap::Evaluator::Noop.new(object, input)) }
  end

  describe '#inverse' do
    subject { object.inverse }

    it { should be(object) }
  end

  describe '#pretty_inspect' do
    subject { object.pretty_inspect }

    it { should eql("Ducktrap::Node::Identity\n") }
  end
end
