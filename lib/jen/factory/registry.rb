module Jen
  module Factory
    # registration module for factory
    module Registry
      def self.included(base)
	base.extend(ClassMethods)
      end
      
      def register!
	logger.info "*** register! #{self.identifier} ***"
	self.class.register(self) if delete_option(:register) { true }
      end

      module ClassMethods
	attr_accessor :factory_registry

	def registry
	  @factory_registry ||= {}
	end

	def register(generator)
	  logger.debug "--- register #{generator.identifier}"
	  registry[generator.identifier] = generator
	end

	def detect(meth)
	  logger.debug "--- detect #{meth}"
	  detect_singular_or_plural(registry.keys, meth.to_sym) 
	end

	def lookup(meth)
	  logger.debug "=== attempting to lookup #{meth}"
	  target_meth = detect(meth)
	  logger.debug "--- target method '#{target_meth}'"
	  # return nil unless target_meth

	  registry[target_meth]
	end
      end
    end
  end
end
