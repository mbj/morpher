require 'spec_helper'

describe Ducktrap, 'for regression a' do

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
              extern do
                forward { :forward }
                inverse { :inverse }
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
    klass.new(:foo => :bar)
  end

  let(:expected_instance) do
    klass.new(:foo => :inverse)
  end

  let(:dump) do
    { 'foo' => :forward }
  end

  it 'should dump from external' do
    dumper.execute(instance).should eql(dump)
  end

  it 'should load from external' do
    loader.execute(dump).should eql(expected_instance)
  end
end
