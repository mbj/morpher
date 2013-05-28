require 'spec_helper'

describe Ducktrap::Node::Custom, '.build' do
  let(:object) { described_class }

  subject { object.build(&block) }

  let(:block) { proc {} }

  let(:result) { mock('Result') }

  it 'should call custom builder and return its object' do
    Ducktrap::Node::Custom::Builder.should_receive(:new) do |&block|
      block.should be(self.block)
      mock(:object => result)
    end
    should be(result)
  end
end

