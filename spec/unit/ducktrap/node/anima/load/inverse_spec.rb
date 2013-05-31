require 'spec_helper'

describe Ducktrap::Node::Anima::Load, '#inverse' do
  let(:object) { described_class.new(model) }
  let(:model)  { mock('Model') }

  subject { object.inverse }

  it { should eql(Ducktrap::Node::Anima::Dump.new(model)) }
end
