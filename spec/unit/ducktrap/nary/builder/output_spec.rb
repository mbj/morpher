require 'spec_helper'

describe Ducktrap::Nary::Builder, '#output' do
  let(:object) { described_class.new(klass)    }
  let(:klass)  { Ducktrap::Node::Block         }
  let(:node)   { Ducktrap::Node::Noop.instance }

  subject { object.object }

  it 'should add node to body' do
    object.add(node)
    should eql(Ducktrap::Node::Block.new([node]))
  end

  it_should_behave_like 'an idempotent method'
end
