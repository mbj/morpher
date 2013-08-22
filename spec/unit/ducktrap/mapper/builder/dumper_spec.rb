require 'spec_helper'

describe Ducktrap::Mapper::Builder, '#dumper' do
  subject do
    block = self.block
    described_class.new(Ducktrap::Mapper) do |mapper|
      mapper.dumper(&block).should be(mapper)
    end
  end

  let(:block)  { dumper = self.dumper; proc { add(dumper) }           }
  let(:dumper) { double('Dumper', :inverse => loader, :frozen? => true) }
  let(:loader) { double('Loader')                                       }

  its(:object) do
    loader = Ducktrap::Node::Block.new([self.loader])
    dumper = Ducktrap::Node::Block.new([self.dumper])
    should eql(Ducktrap::Mapper.new(loader, dumper))
  end
end
