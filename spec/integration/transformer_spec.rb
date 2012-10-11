require 'spec_helper'

describe 'simple ducktrap' do
  subject { ducktrap.run(input) }

  let(:model) do
    Class.new do
      include Anima, Immutable, Equalizer.new(:name, :amount)

      attribute :name
      attribute :amount

      include Equalizer.new(*attribute_set.map(&:name))
    end
  end


  let(:ducktrap) do
    model = self.model

    Ducktrap.build do |block|
      block.params_from_url_encoded
      block.attributes do
        attribute_from_params :name do |name|
          name.primitive(String)
        end

        attribute_from_params :amount do |amount|
          amount.primitive(String)
        end
      end
    end
  end

  context 'when input is fully loadable' do
    let(:input) { 'name=Markus+Schirp&amount=1000' }

    it { should be_successful }

    its(:result) { should eql(model.new(:name => 'Markus Schirp', :amount => '1000')) }
  end

  context 'with invalid integer' do
    let(:input) { 'name=Markus+Schirp&amount=10a0' }

    it { should_not be_successful }

  end

  pending 'when input is empty' do
    let(:input) { 'name=Markus+Schirp&amount=' }

    it { should be_successful }

    its(:result) { should eql(model.new(:name => 'Markus Schirp', :amount => nil)) }
  end

  context 'when input is missing attribute' do
    let(:input) { 'name=Markus+Schirp' }

    it { should be_successful }
    its(:result) { should eql(model.new(:name => 'Markus Schirp', :amount => nil)) }
  end

  pending 'when input is in invalid format' do
    let(:input) { 'name[]=Markus+Schirp' }

    it { should_not be_successful }
    its(:result) { should be(Ducktrap::Undefined) }
  end
end
