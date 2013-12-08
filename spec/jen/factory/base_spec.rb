require 'spec_helper'
# require 'shared/spec_examples'
# require 'shared/spec_fixtures'
# require 'jen/factory/base'
# include Jen::Factory

include Jen

describe Factory::Base do
  it_behaves_like 'an abstract component' # do
  #   let(:klass) { Factory::Base }
  # end
end

