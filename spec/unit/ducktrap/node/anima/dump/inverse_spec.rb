require 'spec_helper'

describe Ducktrap::Node::Anima::Dump, '#inverse' do
  let(:object) { described_class.new(model) }
  let(:model)  { double('Model') }

  subject { object.inverse }

  it { should eql(Ducktrap::Node::Anima::Load.new(model)) }
end
