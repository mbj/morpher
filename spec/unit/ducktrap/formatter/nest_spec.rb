require 'spec_helper'

describe Ducktrap::Formatter, '#nest' do
  subject { object.nest(label, nested) }

  let(:label)  { 'the-label' }
  let(:nested) { mock }

  let(:object) { described_class.new(io) }
  let(:io)     { StringIO.new            }

  before do
    nested.should_receive(:pretty_dump).with(indented).and_return(nested)
  end

  def output
    io.rewind
    io.read
  end
  
  let(:string) { 'the-string' }

  before { subject }

  let(:indented) do
    object.indent.indent
  end

  context 'unindented' do
    it 'should write the string to io' do
      output.should eql("  the-label:\n")
    end

    it_should_behave_like 'a command method'
  end

  context 'indented' do

    let(:object) { super().indent }

    it 'should write the indeted string to io' do
      output.should eql("    the-label:\n")
    end

    it_should_behave_like 'a command method'
  end

end
