module Jen
  module DSL
    def factory(meth,opts={},&blk)
      Factory::Base.new(meth,opts,&blk)
    end

    def generate(entity,opts={},&blk)
      entity_fabricator = Factory::Base.lookup entity
      raise "No generator with name '#{entity}' yet exists. You may want to write one!" unless entity_fabricator

      entity_fabricator.construct!(opts, &blk)
    end
  end
end
