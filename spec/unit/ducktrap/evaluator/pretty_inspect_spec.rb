require 'spec_helper'

describe Ducktrap::Evaluator, '#pretty_inspect' do
  let(:object)  { class_under_test.new(context, input) }
  let(:context) { Ducktrap::Node::Noop.instance        }
  let(:input)   { :input                               }

  subject { object.pretty_inspect }

  context 'successful' do 

    let(:class_under_test) do
      Class.new(described_class) do
        def process
          :output
        end

        def self.name
          'TestEvaluator'
        end
      end
    end

    it 'should return inspected error' do
      should eql(strip(<<-STR))
        TestEvaluator
          input: :input
          output: :output
          context:
            Ducktrap::Node::Noop
      STR
    end
  end

  context 'error' do 

    let(:class_under_test) do
      Class.new(described_class) do
        def process
          error
        end

        def self.name
          'TestEvaluator'
        end
      end
    end

    it 'should return inspected error' do
      should eql(strip(<<-STR))
        TestEvaluator
          input: :input
          error:
            Ducktrap::Error
              input: :input
              context:
                Ducktrap::Node::Noop
          context:
            Ducktrap::Node::Noop
      STR
    end
  end
end
