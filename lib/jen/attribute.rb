module Jen
  class Attribute
    attr_accessor :name, :options, :block
    attr_accessor :count	# number of sub-entities to generate 
    attr_accessor :counter	# this entities index

    def initialize(name,opts={},&block)
      self.options = options
      self.name    = name
      self.block   = block
      self.count   = opts.delete(:count) { 1 }
      self.counter = opts.delete(:counter) { 0 }
    end

    def factory
      @factory ||= Factory::Base.lookup self.name
    end

    def evaluate!
      self.counter = self.counter + 1
      if factory
	if self.name.to_s.plural?
	  # binding.pry
	  Array.new(self.count) { factory.construct! }
	else
	  factory.construct!
	end
      else
	self.block.call(self.counter)
      end
    end
  end
end
