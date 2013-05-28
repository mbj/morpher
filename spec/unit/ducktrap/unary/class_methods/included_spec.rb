require 'spec_helper'

describe Ducktrap::Unary, '.included' do
  subject { klass = described_class; Class.new { include klass } }

  its(:ancestors) { should include(Ducktrap::Unary::InstanceMethods) }
  it { should be_a(Ducktrap::Unary::ClassMethods) }
  its(:public_instance_methods) { should include(:operand) }
end
