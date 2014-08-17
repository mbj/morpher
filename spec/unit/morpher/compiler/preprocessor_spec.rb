require 'spec_helper'

describe Morpher::Compiler::Preprocessor do
  subject { Morpher::Compiler::Preprocessor::DEFAULT.call(input) }

  shared_examples_for 'a preprocessor' do
    it { should eql(expected) }

    it 'is able to compile output' do
      Morpher.compile(subject)
    end
  end

  context 'with s(:boolean)' do

    it_should_behave_like 'a preprocessor' do
      let(:input)    { s(:boolean) }
      let(:expected) { s(:xor, s(:primitive, TrueClass), s(:primitive, FalseClass)) }
    end

  end
end
