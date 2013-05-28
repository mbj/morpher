require 'spec_helper'

describe Ducktrap::Node::Forward, '#inverse' do
  let(:object) { described_class.new(operand) }

  let(:operand) { Ducktrap::Node::Static.new(:foo, :bar) }

  subject { object.inverse }

  it { should eql(Ducktrap::Node::Inverse.new(operand)) }

  it_should_behave_like 'an #inverse method'
end

