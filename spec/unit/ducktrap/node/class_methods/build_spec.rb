require 'spec_helper'

describe Ducktrap::Node, '.build' do
  let(:object) { described_class }

  subject { object.build(&block) }

  let(:block) { proc { noop } }

  it { should eql(Ducktrap::Node::Block.new([Ducktrap::Node::Noop.instance])) }
end
