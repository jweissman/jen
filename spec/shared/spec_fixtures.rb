class Place
  attr_accessor :name
end

class City < Place
  attr_accessor :name, :city_id
  attr_accessor :mayor
  attr_accessor :people
end

class Person
  attr_accessor :person_id, :forename, :surname
  attr_accessor :job, :age
end

##### factory-fixtures ####
PlaceFactory = factory :place do
  name { 'The Moon' }
end

JOBS      = %w[ engineer scientist laborer soldier ]
FORENAMES = %w[ john liam thomas jose rosa emily jessica jennifer ]
SURNAMES  = %w[ wilson williams smith ]
AGE_RANGE = (0..120)

PersonFactory = factory :person do
  forename        { FORENAMES.sample }
  surname         { SURNAMES.sample }
  job             { JOBS.sample }
  age             { AGE_RANGE.to_a.sample }
  person_id       { |i| "person-#{i}" }
end

POPULATION = 1
CityFactory = factory :city do
  name { 'Cloud City' }

  city_id do |index|
    "city-#{index}" 
  end

  mayor { generate :person, job: 'mayor' }
  people # count: POPULATION
end
