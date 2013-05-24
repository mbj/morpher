require 'spec_helper'

describe Ducktrap::Formatter, '#puts' do
  subject { object.puts(string) }

  let(:object) { described_class.new(io) }
  let(:io)     { StringIO.new }

  def output
    io.rewind
    io.read
  end
  
  let(:string) { 'the-string' }

  before { subject }

  context 'unindented' do
    it 'should write the string to io' do
      output.should eql("the-string\n")
    end

    it_should_behave_like 'a command method'
  end

  context 'indented' do
    let(:object) { super().indent }

    it 'should write the indeted string to io' do
      output.should eql("  the-string\n")
    end

    it_should_behave_like 'a command method'
  end

end
