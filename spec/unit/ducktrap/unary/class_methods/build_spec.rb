require 'spec_helper'

describe Ducktrap::Unary::ClassMethods, '.build' do
  context 'without block' do
    subject { Ducktrap::Node::GuardNil.build }

    it { should eql(Ducktrap::Node::GuardNil.new(Ducktrap::Node::Noop.instance)) }
  end

  context 'with block' do
    subject { Ducktrap::Node::GuardNil.build { noop; noop }}

    specify do
      block = Ducktrap::Node::Block.new([Ducktrap::Node::Noop.instance]*2)
      should eql(Ducktrap::Node::GuardNil.new(block))
    end
  end
end
