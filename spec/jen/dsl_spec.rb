require 'spec_helper'
include Jen::DSL

class Bar; attr_accessor :foo end

describe DSL do
  it 'permits entity generation' do
    factory :bar do; end
    generate(:bar).should be_a(Bar)
  end

  context 'generation of entities with attributes' do
    before do
      factory :bar do; foo { 'baz' } end
    end

    it 'uses attribute lambda by default' do
      generate(:bar).foo.should eql('baz')
    end

    it 'overrides with a hash' do
      generate(:bar, foo: 'quux').foo.should eql('quux')
    end
  end
  
  # it 'has factories and generators' do
  #   factory :baz do
  #     quux { 'shlazik' }
  #   end

  #   factory :blah do
  #     foo { 'bar' }
  #     baz
  #   end

  #   generate(:blah).foo.should eql('bar')
  #   generate(:blah, foo: 'car').foo.should eql('car')

  #   generate(:blah).baz.quux.should eql('shlazik')
  # end
end
