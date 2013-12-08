module Jen
  module Factory
    module Construction
      def construct!(opts={},*args,&block)
	logger.debug "=== construct! component_name=#{self.identifier}"
	object = self.target_class.new
	assign_object_attributes!(object,opts)
	logger.debug "--- assigned obj attrs: #{object.inspect}"
	object
      end

      # handle traits/aspects...

      protected

      def assign_attribute!(obj,attr)
	logger.debug "=== assigning attribute #{attr.identifier}"
	target_attr = detect_instance_method self.target_class, attr.identifier
	attr_method = "#{target_attr}="

	attr_value = attr.evaluate!


	logger.debug "--- assigning attribute to object"
	
	logger.debug "--- attribute method #{attr_method}"
	logger.debug "--- attribute value #{attr_value}"
	logger.debug "--- obj before: #{obj.inspect}"
	obj.send attr_method, attr_value
	logger.debug "--- obj after: #{obj.inspect}"
      end

      def assign_object_attributes!(object,provided_attributes)
	logger.debug "=== assigning object attributes (#{self.identifier})"

	provided_attr_names = provided_attributes.keys
	self.attributes.each do |attr| 
	  unless provided_attr_names.include?(attr.identifier)
	    assign_attribute!(object,attr)
	  end
	end

	provided_attributes.each do |k,v|
	  object.send("#{k}=".to_sym, v)
	end
      end
    end
  end
end
