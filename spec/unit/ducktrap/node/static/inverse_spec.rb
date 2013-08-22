require 'spec_helper'

describe Ducktrap::Node::Static, '#inverse' do
  let(:object) { described_class.new(value, inverse_value) }

  let(:value)         { double('Value')         }
  let(:inverse_value) { double('Inverse Value') }

  subject { object.inverse }

  it { should eql(Ducktrap::Node::Static.new(inverse_value, value)) }

  it_should_behave_like 'an #inverse method'
end
