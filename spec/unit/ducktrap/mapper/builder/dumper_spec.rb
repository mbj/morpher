require 'spec_helper'

describe Ducktrap::Mapper::Builder, '#dumper' do
  subject do 
    block = self.block
    described_class.new(Ducktrap::Mapper) do |mapper|
      mapper.dumper(&block).should be(mapper)
    end
  end

  let(:block)  { dumper = self.dumper; proc { add(dumper) } }
  let(:dumper) { mock('Dumper', :inverse => loader, :frozen? => true) }
  let(:loader) { mock('Loader')                                       }

  its(:object) { should eql(Ducktrap::Mapper.new(loader, dumper)) }
end
