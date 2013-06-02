require 'spec_helper'

describe Ducktrap::Singleton, '.included' do
  subject { described_class = self.described_class; Class.new { include described_class } }

  its(:ancestors)      { should include(Ducktrap::Singleton::InstanceMethods) }
  
  it 'should not be possible to create instance via .new' do
    expect { subject.new }.to raise_error
  end

  it { should respond_to(:instance) }
end
