require 'spec_helper'

describe Ducktrap::Node::Custom, '#inverse' do
  let(:object) { described_class.new(:forward, :inverse) }

  subject { object.inverse }

  it { should eql(described_class.new(:inverse, :forward)) }

  it_should_behave_like 'an #inverse method'
end

