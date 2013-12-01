module Jen
  module Factory

    module Traits
      # an aspect extends a factory
      # by adding an 'aspectual' parameter of some kind
      # which is really just like a sub-factory

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
