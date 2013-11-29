module Jen
  module Factory
    class Base
      include Registry
      include Construction

      attr_accessor :factory_name, :factory_options, :block

      def initialize(meth,opts={},&blk)
	@factory_name     = meth
	@factory_options  = opts 
	@block    = blk

	# hook into registry and construction modules
	register!
        instance_eval(&(@block))
      end
    end
  end
end
