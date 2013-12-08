module Jen
  module Factory
    # 
    #  support for factory dsl
    #
    module Plan
      def prepare_for_fabrication!
	logger.debug "--- preparing for fabrication..."
	logger.debug "--- running block if provided..."
	instance_eval(&(self.closure)) if self.closure
      end

      protected

      def create_attribute!(meth,*args,&blk)
	logger.debug "--- creating attribute #{meth}"
	self.attributes << Attribute.new(meth,*args,&blk)
      end

      def method_missing(meth, *args, &blk)
	logger.debug "--- method missing #{meth}"
	opts = args[0]
	if (opts && opts[:class]) || detect_instance_method(self.target_class, meth)
	  create_attribute!(meth,*args,&blk)
	else
	  super
	end
      end
    end
  end
end
