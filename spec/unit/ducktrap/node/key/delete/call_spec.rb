require 'spec_helper'

describe Ducktrap::Node::Key::Delete, '#call' do
  subject { object.call(input) }

  let(:object)  { described_class.new(inverse, key) }
  let(:key)     { double('Key')                       }

  let(:input)   { { key => double('Value') }.freeze }
  let(:inverse) { double('Inverse') }

  its(:output)  { should eql({}) }
end
