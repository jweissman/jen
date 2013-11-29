module Jen
  module Factory
    module Construction
      def prepare_for_fabrication!
	instance_eval(&(self.closure))
      end

      def construct!(opts={},*args,&block)
	object = self.target_class.new
	assign_object_attributes!(object)

	opts.each do |k,v|
	  object.send("#{k}=".to_sym, v)
	end

	object
      end

      # handle traits/aspects...

      protected

      def attributes
	@attributes ||= self.delete_option(:attributes) do
	  []
	end
      end

      def target_class
	@target_class ||= self.delete_option(:class) do
	  self.identifier.to_s.camelize.constantize
	end
      end

      def counter
	@counter ||= self.delete_option(:counter) {0}
	@counter = @counter + 1
      end

      def assign_attribute!(obj,attr)
	target_attr = detect_instance_method self.target_class, attr.identifier
	attr_method = "#{target_attr}="
	attr_value = attr.evaluate!

	obj.send attr_method, attr_value
      end

      def assign_object_attributes!(object)
	self.attributes.each { |attr| assign_attribute!(object,attr) }
      end

      def method_missing(meth, *args, &blk)
	opts = args[0]
	if (opts && opts[:class]) || detect_instance_method(self.target_class, meth)
	  self.attributes << Attribute.new(meth,*args,&blk)
	else
	  super
	end
      end
    end
  end
end
