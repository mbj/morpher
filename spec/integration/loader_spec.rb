require 'spec_helper'

describe 'simple loade' do
  subject { loader.run(input) }

  let(:model) do
    Class.new do
      include Anima, Immutable, Equalizer.new(:name, :amount)

      attribute :name
      attribute :amount

      include Equalizer.new(*attribute_set.map(&:name))
    end
  end


  let(:loader) do
    model = self.model
    Transformator::Chain.build do |chain|
      chain.params_from_url_encoded
      chain.attributes do
        attribute_from_params :name do |name|
          name.primitive(String, NilClass)
        end

        attribute_from_params :amount do |amount|
          amount.primitive(String)
          amount.fixnum_from_string
        end
      end
      chain.anima(model) 
    end
  end

  context 'when input is fully loadable' do
    let(:input) { 'name=Markus+Schirp&amount=1000' }

    it { p subject; should be_successful }
    its(:result) { should eql(model.new(:name => 'Markus Schirp', :amount => 1000)) }
    its(:errors) { should be_empty }
  end

  pending 'when input is missing attribute' do
    let(:input) { 'name=Markus+Schirp' }

    it { should be_successful }
    its(:result) { should eql(model.new(:name => 'Markus Schirp', :amount => nil)) }
    its(:errors) { should be_empty } 
  end

  pending 'when input is in invalid format' do
    let(:input) { 'name[]=Markus+Schirp' }

    it { should_not be_successful }
    its(:result) { should be(Transformator::Undefined) }
    its(:errors) { should eql(:dunno)                  }
  end
end
