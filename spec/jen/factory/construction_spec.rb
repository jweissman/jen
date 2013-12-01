require 'spec_helper'
include Jen::Factory

describe Construction do
  it 'constructs basic attribute' do
    class Baz; attr_accessor :quux end
    class Blah; attr_accessor :foo, :baz end

    factory :baz do
      quux { 'shlazik' }
    end

    factory :blah do
      foo { 'bar' }
      baz
    end

    generate(:blah).foo.should eql('bar')
    generate(:blah, foo: 'car').foo.should eql('car')

    generate(:blah).baz.quux.should eql('shlazik')
  end
end
 
