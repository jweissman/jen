module Jen
  module Factory
    class Base < AbstractComponent
      include Registry
      include Construction

      def initialize(meth,opts={},&blk)
	super(meth,opts,&blk)

	register!
	prepare_for_fabrication!
      end
    end
  end
end
