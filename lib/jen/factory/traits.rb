module Jen
  module Factory
    module Traits
      class Aspect
	def initialize(name,opts={},&blk)
	  @name    = name
	  @options = options
	  @block   = blk
	end
      end

      def aspects
	@aspects ||= []
      end

      def trait(name,opts={},&blk)
	puts "--- creating trait #{name}"
	self.aspects << Aspect.new(name,opts={},&blk)
      end
    end
  end
end
