require 'spec_helper'

describe Ducktrap::Node::Key::Dump, '#inverse' do
  let(:object) { described_class.new(operand, key) }

  let(:operand) { Ducktrap::Node::Static.new(:forward, :inverse) }
  let(:key)     { mock('Key')                                    }

  subject { object.inverse }

  it { should eql(Ducktrap::Node::Key::Fetch.new(operand.inverse, key)) }

  it_should_behave_like 'an #inverse method'
end
