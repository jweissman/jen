require 'spec_helper'

describe Base, "tracks a registry of created entities" do
  # it_behaves_like 'an abstract component'

  it 'has a registration lifecycle' do
    Base.lookup(:foo).should be_nil
    foo_factory = factory :foo
    Base.lookup(:foo).should eql(foo_factory)
  end

  it 'registers spec fixtures' do
    Base.lookup(:city).should eql(CityFactory)
    Base.lookup(:person).should eql(PersonFactory)
  end

  it 'conditionally registers factories (can omit for cleaner testing)' do
    number_factory = Base.new(:number_factory, class: Integer)
    Base.lookup(:number_factory).should eql(number_factory)

    Base.new(:test, register: false)
    Base.lookup(:test).should eql(nil)
  end
end
