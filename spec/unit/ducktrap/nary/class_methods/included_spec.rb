require 'spec_helper'

describe Ducktrap::Nary, '.included' do
  subject { described_class = self.described_class; Class.new { include described_class } }

  its(:ancestors) { should include(Ducktrap::Nary::InstanceMethods) }
  it              { should respond_to(:build) }
end
