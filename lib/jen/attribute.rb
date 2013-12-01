module Jen
  class Attribute < AbstractComponent
    attr_accessor :count	# number of sub-entities to generate 
    attr_accessor :counter	# this entities index

    def initialize(name=nil,opts={},&block)
      super(name,opts,&block)

      self.count   = delete_option(:count)   { 1 }
      self.counter = delete_option(:counter) { 0 }
    end

    def custom_factory
      option_for(:factory) && Factory::Base.lookup(option_for(:factory))
    end

    def factory
      @factory ||= custom_factory || Factory::Base.lookup(self.identifier)
    end

    def evaluate_with_factory
      return factory.construct! if self.identifier.to_s.singular?
      Array.new(self.count) { factory.construct! }
    end

    def evaluate!
      self.counter = self.counter + 1
      return evaluate_with_factory if factory
      return self.closure.call(self.counter) if closure
      raise "No factory or block provided for attribute #{self.identifier}"
    end
  end
end
