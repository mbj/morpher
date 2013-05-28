require 'spec_helper'

describe Ducktrap::Singleton::InstanceMethods, '#inspect' do
  let(:object) do
    Class.new(Ducktrap::Node) do
      include Ducktrap::Singleton

      def self.name
        'Test'
      end
    end.instance
  end

  subject { object.inspect }

  it { should eql('<Test>') }

  it_should_behave_like 'an idempotent method'
end
