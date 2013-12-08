require 'spec_helper'

include Jen

describe AbstractComponent do
   it_behaves_like 'an abstract component' do 
     let(:klass) { AbstractComponent }
    end
end
