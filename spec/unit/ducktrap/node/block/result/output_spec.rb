require 'spec_helper'

describe Ducktrap::Node::Block::Result, '#output' do
  subject { object.output }

  class Mock
    include Adamantium::Flat
    def initialize(name)
      @name = name
      @frozen = false
    end

    def freeze
      @frozen = true
      self
    end

    def frozen? 
      @frozen
    end

    def inspect
      "<#{self.class.name} name=#{@name}>"
    end
    memoize :inspect
  end

  def mymock(name)
    Mock.new(name)
  end

  let(:object) { described_class.new(context, input, body) }

  let(:context) { mymock('Context') }

  let(:input)  { mymock('Input') }

  context 'with empty body' do
    let(:body) { [] }

    it { should be(input) }

    it_should_behave_like 'an idempotent method'
  end

  context 'with body' do
    let(:body) { [trap_a, trap_b] }

    let(:trap_a) { mymock('Ducktrap A') }
    let(:trap_b) { mymock('Ducktrap B') }

    let(:input_a) { mymock('Input A') }
    let(:input_b) { mymock('Input B') }

    let(:output_a) { mymock(:output_a) }
    let(:output_b) { mymock(:output_b) }

    before do
      trap_a.stub(:run => result_a)
      trap_b.stub(:run => result_b)
    end

    context 'without failures' do
      let(:result_a) { Ducktrap::Result::Static.new(context, input_a, output_a) }
      let(:result_b) { Ducktrap::Result::Static.new(context, input_b, output_b) }

      it { should be(output_b) }
      
      it_should_behave_like 'an idempotent method'
    end

    context 'with late failure' do
      let(:result_a) { Ducktrap::Result::Static.new(context, input_a, output_a) }
      let(:result_b) { Ducktrap::Result::Invalid.new(context, input_b) }


      it { should eql(Ducktrap::Error.new(result_b, input)) }

      it_should_behave_like 'an idempotent method'
    end

    context 'with early failure' do
      let(:result_a) { Ducktrap::Result::Invalid.new(context, input_a) }
      let(:result_b) { Ducktrap::Result::Invalid.new(context, input_b) }

      it { should eql(Ducktrap::Error.new(result_a, input)) }

      it 'should not execute later ducktraps' do
        trap_b.should_not_receive(:run)
        subject
      end

      it_should_behave_like 'an idempotent method'
    end
  end
end
