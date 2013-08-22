require 'spec_helper'

describe Ducktrap::FailedTransformationError, '#message' do
  subject { object.message }

  let(:evaluator) { double('Evaluator', :pretty_inspect => 'blah') }
  let(:object)    { described_class.new(evaluator)               }

  it { should eql('blah') }
end
