require 'spec_helper'

describe Ducktrap::PrettyDump, '#pretty_inspect' do

  subject { object.pretty_inspect }

  let(:object) { class_under_test.new }

  let(:class_under_test) do
    Class.new do
      include Ducktrap::PrettyDump

    private

      def dump(formatter)
        formatter.attribute(:foo, 'bar')
      end
    end
  end

  it { should eql(%Q(  foo: "bar"\n)) }
end
