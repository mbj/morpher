require 'spec_helper'

describe Ducktrap::Nary, '.included' do
  subject { described_class = self.described_class; Class.new { include described_class } }

  its(:ancestors) { should include(Ducktrap::Nary::InstanceMethods) }
  it              { should respond_to(:build) }

  specify do
    subject.new(:foo).should eql(subject.new(:foo))
    subject.new(:foo).should_not eql(subject.new(:bar))
  end
end
