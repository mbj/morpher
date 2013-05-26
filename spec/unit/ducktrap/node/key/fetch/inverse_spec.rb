require 'spec_helper'

describe Ducktrap::Node::Key::Fetch, '#inverse' do
  let(:object) { described_class.new(operand, key) }

  let(:operand) { Ducktrap::Node::Static.new(:forward, :inverse) }
  let(:key)     { mock('Key')                                    }

  subject { object.inverse }

  it { should eql(Ducktrap::Node::Key::Dump.new(operand.inverse, key)) }
end
