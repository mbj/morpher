require 'spec_helper'

describe Ducktrap::Singleton::ClassMethods, '#instance' do
  let(:object) do 
    Class.new do 
      include Ducktrap::Singleton

      def self.name
        'Test'
      end
    end
  end

  subject { object.instance }

  it_should_behave_like 'an idempotent method'

  it { should be_a(object) }
end
