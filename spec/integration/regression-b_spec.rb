require 'spec_helper'

describe Ducktrap, 'for regression b' do

  let(:klass) do
    Class.new do
      include Anima.new(:foo)
    end
  end

  let(:dumper) do
    klass = self.klass

    Ducktrap::Block.build do
      anima_dump(klass) do
        collect_hash do
          fetch_key(:foo) do
            dump_key('foo') do
              anima_dump(klass) do
                fetch_key(:foo) do
                  dump_key('foo')
                end
              end
            end
          end
        end
      end
    end
  end

  let(:loader) do
    dumper.inverse
  end

  let(:instance) do
    klass.new(:foo => klass.new(:foo => :bar))
  end

  let(:dump) do
    { 'foo' => { 'foo' => :bar } }
  end

  it 'should dump from external' do
    dumper.execute(instance).should eql(dump)
  end

  it 'should load from external' do
    loader.execute(dump).should eql(instance)
  end
end
