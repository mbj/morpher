require 'spec_helper'

describe Ducktrap::Nullary, '.included' do
  subject { klass = described_class; Class.new { include klass } }

  it { should respond_to(:build) }
end
