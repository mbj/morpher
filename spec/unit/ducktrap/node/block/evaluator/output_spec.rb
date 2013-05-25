require 'spec_helper'

describe Ducktrap::Node::Block::Evaluator, '#output' do
  subject { object.output }

  let(:object)  { described_class.new(context, input) }
  let(:context) { mymock('Context', :body => body)    }
  let(:input)   { :input                              }

  def mymock(name, attributes={})
    mock(name, attributes.merge(:frozen? => true))
  end

  context 'without elements in block' do
    let(:body) { [] }

    it { should be(input) }

    it_should_behave_like 'an idempotent method'
  end

  context 'with elements in block' do
    let(:body) { [trap_a, trap_b] }

    context 'without failures' do
      let(:trap_a) { Ducktrap::Node::Noop.instance }
      let(:trap_b) { Ducktrap::Node::Noop.instance }

      it { should be(input) }
      
      it_should_behave_like 'an idempotent method'
    end

    context 'with late failure' do
      let(:trap_a) { Ducktrap::Node::Static.new(:forward, :inverse) }
      let(:trap_b) { Ducktrap::Node::Invalid.instance }

      its(:pretty_inspect) do 
        should eql(strip(<<-STR))
          Ducktrap::Error
            input: :input
            context:
              Ducktrap::Evaluator::Invalid
                input: :forward
                error:
                  Ducktrap::Error
                    input: :forward
                    context:
                      Ducktrap::Node::Invalid
                context:
                  Ducktrap::Node::Invalid
        STR
      end
    end

    context 'with early failure' do
      let(:trap_a) { Ducktrap::Node::Invalid.instance }
      let(:trap_b) { mock('Late Node')                }

      its(:pretty_inspect) do 
        should eql(strip(<<-STR))
          Ducktrap::Error
            input: :input
            context:
              Ducktrap::Evaluator::Invalid
                input: :input
                error:
                  Ducktrap::Error
                    input: :input
                    context:
                      Ducktrap::Node::Invalid
                context:
                  Ducktrap::Node::Invalid
        STR
      end
    end

  end
end
