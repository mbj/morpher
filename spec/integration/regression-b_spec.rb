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
      attributes_hash_from_anima(klass)
      params_hash_from_attributes_hash_extraction do
        params_hash_from_attribute(:foo) do
          attributes_hash_from_anima(klass)
          params_hash_from_attributes_hash_extraction do
            params_hash_from_attribute(:foo)
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
    dumper.run(instance).output.should eql(dump)
  end

  it 'should load from external' do
    loader.run(dump).output.should eql(instance)
  end
end
