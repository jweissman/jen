module Jen
  # a lot of our classes have this structure, might as well encapsulate it
  class AbstractComponent
    attr_accessor :component_name, :component_options, :component_block

    def initialize(component_name=nil, component_options={}, &component_block)
      @component_name    = component_name
      @component_options = component_options
      @component_block   = component_block
    end

    def identifier
      @component_name
    end
    
    def delete_option(k,&blk)
      @component_options.delete(k,&blk)
    end

    def option_for(k)
      @component_options && @component_options[k]
    end

    def closure
      @component_block ||= proc {}
    end
  end
end

