require 'spec_helper'

describe Ducktrap::Mapper::Builder, '#loader' do
  subject do 
    block = self.block
    described_class.new(Ducktrap::Mapper) do |mapper|
      mapper.loader(&block).should be(mapper)
    end
  end

  let(:block)  { loader = self.loader; proc { add(loader) } }
  let(:loader) { mock('Loader', :inverse => dumper, :frozen? => true) }
  let(:dumper) { mock('Dumper')                                       }

  its(:object) do 
    loader = Ducktrap::Node::Block.new([self.loader])
    dumper = Ducktrap::Node::Block.new([self.dumper])
    should eql(Ducktrap::Mapper.new(loader, dumper))
  end
end
