require 'spec_helper'

describe Base, 'assembles objects according to plan specifications' do
  it_behaves_like 'an abstract component'
  context 'place fixture' do
    subject do
      generate :place 
    end

    it 'simple constant values' do
      subject.name.should eql('The Moon')
    end
  end

  context 'city fixture' do
    subject { generate :city }
    describe 'constants and interation attributes' do 
      context 'value generation' do
        describe 'constant values' do
          its(:name) { should eql('Cloud City') } # /[A-Za-z]/) }

          it 'should have gotten named appropriately' do
            # binding.pry
            subject.name.should match(/[A-Za-z]/)
          end
        end


        describe 'iterable elements' do
          its(:city_id) { should match(/city-[0-9]/) }
        end
      end
    end

    describe 'complex attributes' do
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


end

