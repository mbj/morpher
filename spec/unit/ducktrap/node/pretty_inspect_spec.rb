require 'spec_helper'

describe Ducktrap::Node, '#pretty_inspect' do
  let(:object) { class_under_test.new }

  let(:class_under_test) do
    Class.new(described_class) do
      def self.name
        'Test'
      end
    end
  end

  subject { object.pretty_inspect }

  it { should eql("Test\n") }
end
