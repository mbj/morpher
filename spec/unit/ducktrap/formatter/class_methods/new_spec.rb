require 'spec_helper'

describe Ducktrap::Formatter, '.new' do
  subject { object.new(*arguments) }
  let(:object) { described_class }

  context 'with defaults' do
    let(:arguments) { [] }
    it 'should write to stderr' do
      $stderr.should_receive(:puts).with('Class').and_return($stderr)
      subject.name(described_class)
    end
  end
end
