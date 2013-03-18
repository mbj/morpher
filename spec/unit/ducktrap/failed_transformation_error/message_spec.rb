require 'spec_helper'

describe Ducktrap::FailedTransformationError, '#message' do
  subject { object.message }

  let(:result) { mock('Result', :pretty_inspect => 'blah') }
  let(:object) { described_class.new(result)               }

  it { should eql('blah') }
end
