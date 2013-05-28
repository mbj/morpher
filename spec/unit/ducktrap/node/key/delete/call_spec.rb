require 'spec_helper'

describe Ducktrap::Node::Key::Delete, '#call' do
  subject { object.call(input) }

  let(:object)  { described_class.new(inverse, key) }
  let(:key)     { mock('Key')                       }

  let(:input)   { { key => mock('Value') }.freeze }
  let(:inverse) { mock('Inverse') }

  its(:output)  { should eql({}) }
end
