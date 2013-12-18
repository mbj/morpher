require 'spec_helper'

describe Morpher::Evaluator::Parameterized do

  describe '.include' do
    let(:object) do
      Class.new(Morpher::Evaluator) do
        include Morpher::Evaluator::Parameterized

        def self.name
          'Foo'
        end
      end
    end

    let(:instance) do
      object.new('foo')
    end

    it 'sets up printer' do
      instance.description.should eql(strip(<<-'TEXT'))
        Foo
          param: "foo"
      TEXT
    end

    it 'sets up .build' do
      expect(object.build(Morpher::Compiler.new(Morpher::Evaluator::REGISTRY), s(:foo, 'foo'))).to eql(instance)
    end
  end
end
