require 'spec_helper'

describe Ducktrap::Nullary::ClassMethods, '#build' do
  let(:object) do 
    Class.new do 
      include Equalizer.new(:arguments)
      extend Ducktrap::Nullary::ClassMethods
      attr_reader :arguments
      def initialize(*arguments)
        @arguments = arguments
      end

      def self.name
        'Test'
      end
    end
  end

  subject { object.build(*arguments, &block) }

  context 'with arguments' do
    let(:arguments) { [:foo, :bar] }
    let(:block)     { nil          }

    it { should eql(object.new(:foo, :bar)) }
  end

  context 'with block' do
    let(:arguments) { [] }
    let(:block)     { proc {} }

    it 'should raise error' do
      expect { subject }.to raise_error(RuntimeError, 'Test.build does not take a block')
    end
  end

end
