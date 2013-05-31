require 'spec_helper'

describe Ducktrap::Singleton::InstanceMethods, '#pretty_inspect' do
  let(:object) do
    Class.new(Ducktrap::Node) do
      include Ducktrap::Singleton

      def self.name
        'Test'
      end
    end.instance
  end

  subject { object.pretty_inspect }

  it { should eql("Test\n") }
end
