require 'spec_helper'

describe Ducktrap::Node::Inverse, '#inverse' do
  let(:object) { described_class.new(operand) }

  let(:operand) { Ducktrap::Node::Static.new(:foo, :bar) }

  subject { object.inverse }

  it { should eql(Ducktrap::Node::Forward.new(operand)) }

  it_should_behave_like 'an #inverse method'
end

