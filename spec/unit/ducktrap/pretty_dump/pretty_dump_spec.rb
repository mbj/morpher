require 'spec_helper'

describe Ducktrap::PrettyDump, '#pretty_dump' do

  subject { object.pretty_dump(*arguments) }

  let(:object) { class_under_test.new }

  let(:class_under_test) do
    Class.new do
      include Ducktrap::PrettyDump

    private

      def dump(formatter)
        formatter.attribute(:foo, 'bar')
      end
    end
  end

  context 'with argument' do
    let(:arguments) { [formatter] }

    let(:output)    { StringIO.new }
    let(:formatter) { Ducktrap::Formatter.new(output) }

    it 'should write to argument' do
      subject
      output.rewind
      output.read.should eql(%Q(  foo: "bar"\n))
    end

    it_should_behave_like 'a command method'
  end

  context 'without formatter' do
    let(:arguments) { [] }

    it 'should write to argument' do
      $stderr.should_receive(:puts).with(%Q(foo: "bar")).and_return($stderr)
      subject
    end

    it_should_behave_like 'a command method'
  end

end
