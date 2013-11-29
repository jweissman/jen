require 'spec_helper'
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
end
