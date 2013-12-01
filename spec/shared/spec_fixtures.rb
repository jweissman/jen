
class City
  attr_accessor :name, :id
  attr_accessor :mayor
  attr_accessor :people
end

class Person
  attr_accessor :id, :forename, :surname
  attr_accessor :job, :age
end

##### factory-fixtures ####
JOBS = %w[ engineer scientist laborer soldier ]
FORENAMES = %w[ john liam thomas jose rosa emily jessica jennifer ]
SURNAMES = %w[ wilson williams smith ]
AGE_RANGE = (0..120)

PersonFactory = factory :person do
  forename { FORENAMES.sample }
  surname  { SURNAMES.sample }
  job      { JOBS.sample }
  age      { AGE_RANGE.to_a.sample }
  id       { |i| "person-#{i}" }
end

POPULATION = 10
CityFactory = factory :city do
  name { 'Cloud City' }

  id do |index|
    "city-#{index}" 
  end

  mayor { generate :person, job: 'mayor' }
  people count: POPULATION
end
