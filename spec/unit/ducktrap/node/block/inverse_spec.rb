require 'spec_helper'

describe Ducktrap::Node::Block, '#inverse' do
  let(:object) { described_class.new(body) }

  subject { object.inverse }

  let(:body) do
    [
      Ducktrap::Node::Static.new(:forward, :inverse)
    ]
  end

  it 'should return inverse' do
    inverse_body = [ Ducktrap::Node::Static.new(:inverse, :forward) ]
    should eql(described_class.new(inverse_body))
  end

  it_should_behave_like 'an #inverse method'
end
