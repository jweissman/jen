module Jen
  class Attribute < AbstractComponent
    attr_accessor :count	# number of sub-entities to generate 
    attr_accessor :counter	# this entities index

    def initialize(name=nil,opts={},&block)
      super(name,opts,&block)
      logger.info "=== new attribute #{self.identifier}"

      self.count   = self.delete_option(:count)   { 1 }
      self.counter = self.delete_option(:counter) { 0 }

      logger.debug "am i using factory? #{using_factory?}"
      logger.debug "am i using a closure? #{using_closure?}"
      # binding.pry if self.identifier == :people
    end

    def custom_factory
      option_for(:factory) && Factory::Base.lookup(option_for(:factory))
    end

    def factory
      @factory ||= custom_factory || Factory::Base.lookup(self.identifier)
    end

    def using_factory?
      !!(factory)
    end

    def using_closure?
      !!(closure)
    end

    def evaluate_with_factory
      logger.info '--- eval with factory'
      return factory.construct! if self.identifier.to_s.singular?
      logger.info '=== assembling collection'
      Array.new(self.count) { factory.construct! }
    end

    def evaluate_with_closure
      logger.info '--- eval with closure'
      self.counter = self.counter + 1
      self.closure.call(self.counter)
    end

    def evaluate!
      raise "No factory or block provided for attribute #{self.identifier}" unless factory or closure

      logger.info "=== evaluating attribute #{self.identifier}"

      value = if using_closure?
	evaluate_with_closure
      elsif using_factory?
	evaluate_with_factory
      end

      logger.info "--- got value #{value}"
      value
      # return self.closure.call(self.counter) if closure
      # return evaluate_with_factory if factory

    end
  end
end
