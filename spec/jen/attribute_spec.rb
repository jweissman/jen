require 'spec_helper'

include Jen

describe Attribute do
  it_behaves_like 'an abstract component' # do
  #   let(:klass) { Attribute } 
  # end

  context 'with a closure' do
    subject do
      Attribute.new(:foo) { 'bar' }
    end

    its(:value) { should eql 'bar' }
  end

  # it 'takes a closure' do
  #   attr = Attribute.new
end
