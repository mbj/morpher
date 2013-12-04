require 'spec_helper'

describe Morpher::Evaluator::Nary do

  describe '.include' do
    let(:object) do
      Class.new(Morpher::Evaluator) do
        include Morpher::Evaluator::Nary

        def self.name
          'Foo'
        end
      end
    end

    let(:instance) do
      object.new([
        Morpher::Evaluator::Predicate::EQL.new('foo')
      ])
    end

    it 'sets up printer' do
      instance.description.should eql(strip(<<-'TEXT'))
        Foo
          body:
            Morpher::Evaluator::Predicate::EQL
              param: "foo"
      TEXT
    end

    it 'sets up .build' do
      expect(object.build(Morpher::Compiler.new(Morpher::REGISTRY), s(:foo, s(:eql, 'foo')))).to eql(instance)
    end
  end
end
