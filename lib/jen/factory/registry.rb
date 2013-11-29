module Jen
  module Factory
    # registration module for factory
    module Registry
      def self.included(base)
	base.extend(ClassMethods)
      end
      
      def register!
	self.class.register self
      end

      module ClassMethods
	def registry
	  @registry ||= {}
	end

	def register(generator)
	  self.registry[generator.identifier] = generator
	end

	def detect(meth)
	  detect_singular_or_plural(registry.keys, meth.to_sym) 
	end

	def lookup(meth)
	  target_meth = detect(meth)
	  registry[target_meth]
	end
      end
    end
  end
end
