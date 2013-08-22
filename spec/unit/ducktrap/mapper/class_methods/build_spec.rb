require 'spec_helper'

describe Ducktrap::Mapper do

  let(:object) { described_class }

  subject { described_class.build(&block) }

  let(:block)   { proc {}                            }
  let(:builder) { double('Builder', :object => mapper) }
  let(:mapper)  { double('Mapper')                     }

  it 'should call Ducktrap::Mapper::Builder' do
    Ducktrap::Mapper::Builder.should_receive(:new).with(described_class) do |&block|
      block.should be(self.block)
      builder
    end
    subject.should be(mapper)
  end
end
