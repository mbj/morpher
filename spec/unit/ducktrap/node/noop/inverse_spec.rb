require 'spec_helper'

describe Ducktrap::Node::Noop, '#inverse' do
  let(:object) { described_class.instance }

  subject { object.inverse }

  it { should be(object) }
end
