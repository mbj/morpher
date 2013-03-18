require 'spec_helper'

describe Ducktrap::Key::Delete, '#inverse' do
  subject { object.inverse }

  let(:object)  { described_class.new(inverse, key) }
  let(:key)     { mock('Key')                       }
  let(:inverse) { mock('Inverse') }

  it { should eql(Ducktrap::Key::Add.new(inverse, key)) }
end
