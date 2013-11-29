class City
  attr_accessor :name, :id
  attr_accessor :mayor
  attr_accessor :people
end

class Person
  attr_accessor :id, :forename, :surname
  attr_accessor :job, :age
end

##### factories ####
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

  # trait :mayor do
  #   job { 'mayor' }
  # end

  # traits can override attributes with custom behavior... maybe even custom subclass
  # trait :worker do
  #   job { Jobs.sample }
  # end

  # trait :young do
  #   age { (20..50).to_a.sample }
  # end

  # trait :mayor do
  #   job { 'mayor' }
  # end
end

# factories have an index you can use
POPULATION = 10
CityFactory = factory :city do
  name { 'Cloud City' }
  id do |index|
    "city-#{index}" 
  end

  # would seem obvious
  mayor { generate :person, job: 'mayor' }
  # do
  #   generate :person do
  #     job { 'mayor' }
  #   end
  # end
  # factory: :person do # , attribtues: { job: 'mayor' }
  #   job { 'mayor' }
  # end
  # mayor
  people count: POPULATION
end
