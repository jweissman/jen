require 'rspec'
require 'pry'

require 'jen'
include Jen
include Jen::Factory
include Jen::DSL
require 'shared/spec_examples'
require 'shared/spec_fixtures'

# RSpec.configure do |c|
#   c.around(:each) do |example|
#     example.run
#   end
# end
