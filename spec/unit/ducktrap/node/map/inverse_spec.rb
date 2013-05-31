require 'spec_helper'

describe Ducktrap::Node::Map, '#inverse' do
  let(:object) { described_class.new(operand) }

  let(:operand) do
    Ducktrap::Node::Static.new(:foo, :bar)
  end

  subject { object.inverse }

  it { should eql(described_class.new(operand.inverse)) }

  it_should_behave_like 'an #inverse method'
end
