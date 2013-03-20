require 'spec_helper'

describe Ducktrap::Node::Key::Delete, '#inverse' do
  subject { object.inverse }

  let(:object)  { described_class.new(inverse, key) }
  let(:key)     { mock('Key')                       }
  let(:inverse) { mock('Inverse') }

  it { should eql(Ducktrap::Node::Key::Add.new(inverse, key)) }
end
