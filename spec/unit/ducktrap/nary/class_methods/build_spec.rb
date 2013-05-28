require 'spec_helper'

describe Ducktrap::Nary::ClassMethods, '#build' do
  let(:object) { Object.new.extend(described_class) }

  subject { object.build(:foo, :bar, &block) }

  let(:block) { proc {} }

  let(:output) { mock('Output') }

  it 'should delegate to nary builder' do
    Ducktrap::Nary::Builder.should_receive(:new) do |first, second, third, &block|
      first.should be(object)
      second.should be(:foo)
      third.should be(:bar)
      block.should be(self.block)
      mock(:object => output)
    end
    subject.should be(output)
  end
end
