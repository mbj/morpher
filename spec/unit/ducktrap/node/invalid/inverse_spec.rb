require 'spec_helper'

describe Ducktrap::Node::Invalid, '#inverse' do
  let(:object) { described_class.instance }

  subject { object.inverse }

  it { should eql(object) }
end
