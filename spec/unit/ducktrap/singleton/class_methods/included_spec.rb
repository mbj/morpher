require 'spec_helper'

describe Ducktrap::Singleton, '.included' do
  subject { described_class = self.described_class; Class.new { include described_class } }

  its(:ancestors) { should include(Ducktrap::Singleton::InstanceMethods) }
  it { should respond_to(:instance) }
  its(:public_methods) { should_not include(:new) }
end
