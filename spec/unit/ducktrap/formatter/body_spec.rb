require 'spec_helper'

describe Ducktrap::Formatter, '#body' do
  let(:object) { described_class.new(output) }

  let(:output) { StringIO.new }

  subject { object.body(node) }

  let(:node) { [Ducktrap::Node::Noop.instance, Ducktrap::Node::Noop.instance] }

  it 'should print node with members' do
    subject
    output.rewind
    output.read.should eql("  body:\n    Ducktrap::Node::Noop\n    Ducktrap::Node::Noop\n")
  end

  it_should_behave_like 'a command method'
end
