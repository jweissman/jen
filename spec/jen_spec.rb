require 'spec_helper'
require 'shared/spec_fixtures'
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
    subject { generate :city } 

    describe 'with a basic trait' do
      its('mayor') { should be_a(Person) }
      its('mayor.job') { should eql('mayor') }
    end

    context 'collections' do
      describe 'a simple collection' do
	its('people.first') { should be_a(Person) }
	its('people.count') { should eql(POPULATION) }
      end
    end
    
    context 'with traits/aspects' do
      let :person do
        # generate :person
	subject.people.first
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
