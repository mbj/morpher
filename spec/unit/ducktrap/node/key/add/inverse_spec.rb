require 'spec_helper'

describe Ducktrap::Node::Key::Add, '#inverse' do

  subject { object.inverse }

  let(:object)  { described_class.new(inverse, key) }
  let(:key)     { mock('Key')                       }
  let(:inverse) { mock('Inverse') }

  it { should eql(Ducktrap::Node::Key::Delete.new(inverse, key)) }

  it_should_behave_like 'an #inverse method'
end
