require 'spec_helper'

describe Ducktrap::Node::Primitive, '#inverse' do
  let(:object) { described_class.new(primitive) }

  let(:primitive)     { mock('Primitive')     }

  subject { object.inverse }

  it { should be(object) }
end
