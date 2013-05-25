require 'spec_helper'

describe Ducktrap::Error::Exception, '#pretty_inspect' do
  let(:object) { described_class.new(context, input, exception) }

  let(:context)   { Ducktrap::Node::Noop.instance   }
  let(:input)     { :input                          }
  let(:exception) { RuntimeError.new('foo-message') }

  subject { object.pretty_inspect }

  it 'should return inspected error' do
    should eql(strip(<<-STR))
      Ducktrap::Error::Exception
        input: :input
        exception: RuntimeError
        exception_message: "foo-message"
        context:
          Ducktrap::Node::Noop
    STR
  end
end
