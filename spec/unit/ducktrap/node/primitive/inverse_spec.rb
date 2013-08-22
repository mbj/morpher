require 'spec_helper'

describe Ducktrap::Node::Primitive, '#inverse' do
  let(:object)    { described_class.new(primitive) }
  let(:primitive) { double('Primitive')     }

  subject { object.inverse }

  it { should be(object) }

  it_should_behave_like 'an #inverse method'
end
