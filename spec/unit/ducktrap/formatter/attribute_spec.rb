require 'spec_helper'

describe Ducktrap::Formatter, '#attribute' do
  subject { object.attribute(label, value) }

  let(:object) { described_class.new(io) }
  let(:io)     { StringIO.new }

  def output
    io.rewind
    io.read
  end

  before { subject }

  let(:label) { 'label' }
  let(:value) { 'value' }

  it 'should print indented labeled value' do
    output.should eql(%Q(  label: "value"\n))
  end

  it_should_behave_like 'a command method'
end
