require 'spec_helper'

describe Ducktrap::Formatter, '#name' do
  subject { object.name(target) }

  let(:object) { described_class.new(io) }
  let(:io)     { StringIO.new }

  def output
    io.rewind
    io.read
  end

  before { subject }

  let(:target) do
    double(:class => double(:name => 'Target'))
  end

  it 'should print name of targets class' do
    output.should eql("Target\n")
  end

  it_should_behave_like 'a command method'
end
