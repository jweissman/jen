module Jen
  module Factory
    module Construction
      def construct!(opts={},*args,&block)
	object = self.target_class.new
	assign_object_attributes!(object)
	object
      end

      protected

      def attributes
	@attributes ||= self.factory_options.delete(:attributes) do
	  []
	end
      end

      def target_class
	@klass ||= self.factory_options.delete(:class) do
	  self.factory_name.to_s.camelize.constantize
	end
      end

      def counter
	@counter ||= self.factory_options.delete(:counter) {0}
	@counter = @counter + 1
      end

      def assign_attribute!(obj,attr)
	target_attr = detect_instance_method self.target_class, attr.name
	attr_method = "#{target_attr}="
	attr_value = attr.evaluate!

	obj.send attr_method, attr_value
      end

      def assign_object_attributes!(object)
	self.attributes.each { |attr| assign_attribute!(object,attr) }
      end

      def method_missing(meth, *args, &blk)
	if detect_instance_method(self.target_class, meth)
	  self.attributes << Attribute.new(meth,*args,&blk) # [meth] = blk 
	else
	  super
	end
      end
    end
  end
end
