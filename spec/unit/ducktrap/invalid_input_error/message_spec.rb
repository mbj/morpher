require 'spec_helper'

describe Ducktrap::InvalidInputError, '#message' do
  subject { object.message }

  let(:error) { mock('Error') }
  let(:object) { described_class.new(error) }

  before do
    error.stub(:pretty_dump) do |formatter|
      formatter.output.write('blah')
    end
  end

  it { should eql('blah') }
end
