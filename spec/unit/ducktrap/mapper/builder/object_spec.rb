require 'spec_helper'

describe Ducktrap::Mapper::Builder, '#object' do
  let(:object) do
    described_class.new(Ducktrap::Mapper, &block)
  end

  subject { object.object }

  let(:loader) { mock('Loader', :frozen? => true) }
  let(:dumper) { mock('Dumper', :frozen? => true) }

  context 'with loader' do
    let(:block) do
      node = self.loader
      proc do
        loader do
          add(node)
        end
      end
    end

    before do
      loader.stub(:inverse => dumper)
    end

    specify do 
      loader = Ducktrap::Node::Block.new([self.loader])
      dumper = Ducktrap::Node::Block.new([self.dumper])
      should eql(Ducktrap::Mapper.new(loader, dumper))
    end
  end

  context 'with dumper' do
    let(:block) do
      node = self.dumper
      proc do
        dumper do
          add(node)
        end
      end
    end

    before do
      dumper.stub(:inverse => loader)
    end

    specify do 
      loader = Ducktrap::Node::Block.new([self.loader])
      dumper = Ducktrap::Node::Block.new([self.dumper])
      should eql(Ducktrap::Mapper.new(loader, dumper))
    end
  end

  context 'with loader and dumper' do
    let(:block) do
      dumper = self.dumper
      loader = self.loader
      proc do
        dumper do
          add(dumper)
        end

        loader do
          add(loader)
        end
      end
    end

    specify do 
      loader = Ducktrap::Node::Block.new([self.loader])
      dumper = Ducktrap::Node::Block.new([self.dumper])
      should eql(Ducktrap::Mapper.new(loader, dumper))
    end
  end

  context 'without loader or dumper' do
    let(:block) do
    end

    it 'should raise error' do
      expect { subject }.to raise_error(RuntimeError, 'Did not specify loader or dumper or both')
    end
  end
end
