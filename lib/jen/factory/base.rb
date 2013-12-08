module Jen
  module Factory
    class Base < AbstractComponent
      include Registry
      include Construction
      include Plan
      # include Traits

      def initialize(meth=nil,opts={},*args,&blk)
	super(meth,opts,&blk)
	register!
	prepare_for_fabrication!
      end

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
    end
  end
end
