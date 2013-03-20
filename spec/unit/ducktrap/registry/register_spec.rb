require 'spec_helper'

describe Ducktrap::Registry, '#register' do
  subject { object.register(name, node) }

  let(:object) { Ducktrap::Registry.new }
  let(:name)   { mock('Name')           }
  let(:node)   { mock('Node')           }

  it_should_behave_like 'a command method'

  context 'when registring name twice' do
    before do
      object.register(name, node)
    end

    it 'should raise error' do
      expect { subject }.to raise_error(RuntimeError, "name: #{name.inspect} does already exist")
    end
  end
end
