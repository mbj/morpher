require 'spec_helper'

describe 'simple mutator' do
  subject { mutator.run(input) }

  let(:model) do
    Class.new do
      include Anima, Immutable, Equalizer.new(:name, :amount)

      attribute :name
      attribute :amount

      include Equalizer.new(*attribute_set.map(&:name))
    end
  end


  let(:mutator) do
    model = self.model
    Mutator::Block.new do |block|
      block.params_from_url_encoded
      block.attributes do
        attribute_from_params :name do |name|
          name.whitelist_strict do |whitelist|
            whitelist.primitive(String)
            whitelist.primitive(NilClass)
          end
        end

        attribute_from_params :amount do |amount|
          amount.whitelist_strict do |whitelist|
            whitelist.fixnum_from_string
            whitelist.nil_from_empty_string
            whitelist.primitive(NilClass)
          end
        end
      end
      block.anima(model) 
    end
  end

  context 'when input is fully loadable' do
    let(:input) { 'name=Markus+Schirp&amount=1000' }

    it { should be_successful }

    its(:result) { should eql(model.new(:name => 'Markus Schirp', :amount => 1000)) }
  end

  pending 'when input is missing attribute' do
    let(:input) { 'name=Markus+Schirp' }

    it { should be_successful }
    its(:result) { should eql(model.new(:name => 'Markus Schirp', :amount => nil)) }
  end

  pending 'when input is in invalid format' do
    let(:input) { 'name[]=Markus+Schirp' }

    it { should_not be_successful }
    its(:result) { should be(Mutator::Undefined) }
  end
end
