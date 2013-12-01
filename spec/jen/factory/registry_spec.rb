require 'spec_helper'
require 'shared/spec_fixtures'
include Jen::Factory

describe Registry do
  it 'has a registration lifecycle' do
    Base.lookup(:foo).should be_nil
    foo_factory = factory :foo
    Base.lookup(:foo).should eql(foo_factory)
  end

  it 'registers spec fixtures' do
    Base.lookup(:city).should eql(CityFactory)
    Base.lookup(:person).should eql(PersonFactory)
  end

  it 'conditionally registers factories (omit for testing)' do
    number_factory = Base.new(:number_factory, class: Integer)
    Base.lookup(:number_factory).should eql(number_factory)

    Base.new(:test, register: false)
    Base.lookup(:test).should eql(nil)
  end
end
