require 'spec_helper'

describe Ducktrap::Unary, '.included' do
  subject { klass = described_class; Class.new { include klass } }

  its(:ancestors) { should include(Ducktrap::Unary::InstanceMethods) }
  it { should be_a(Ducktrap::Unary::ClassMethods) }
  its(:public_instance_methods) { should include(:operand) }

  specify do
    subject.new(:foo).should eql(subject.new(:foo))
    subject.new(:foo).should_not eql(subject.new(:bar))
  end
end
