require 'spec_helper'

describe Ducktrap::Node::GuardNil, '#inverse' do
  subject { object.inverse }

  let(:object)  { described_class.new(operand)           }
  let(:operand) { Ducktrap::Node::Static.new(:foo, :bar) }

  it { should eql(described_class.new(operand.inverse)) }

  it_should_behave_like 'an #inverse method'
end
