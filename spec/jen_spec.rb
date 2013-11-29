require 'spec_helper'
require 'jen'

describe Jen do
  context 'package' do
    it "should have a VERSION constant" do
      subject.const_get('VERSION').should_not be_empty
    end
  end

  describe 'simple attributes' do
    subject { generate(:city) }
    context 'value generation' do
      describe 'constant values' do
	its(:name) { should match(/[A-Za-z]/) }
      end

      describe 'iterable elements' do
	its(:id) { should match(/city-[0-9]/) }
      end
    end
  end

  describe 'complex attributes' do
    context 'collections' do
      subject { generate :city }
      describe 'a simple collection' do
	its('people.first') { should be_a(Person) }
	its('people.count') { should eql(POPULATION) }
      end
    end
    
    context 'with traits' do
      let :person do
        generate :person
      end
      
      it 'should have a job' do
	JOBS.should include person.job
      end

      it 'should have a name' do
	FORENAMES.should include person.forename
	SURNAMES.should include person.surname
      end
    end
  end
end
