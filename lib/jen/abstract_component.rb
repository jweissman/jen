module Jen
  # a lot of our classes have this structure, might as well encapsulate it
  class AbstractComponent
    # attr_accessor :name # , :options # , :block
    def initialize(name=nil, options={}, *args, &block)
      @name     = name || :anonymous_component
      @options  = options
      @block    = block

      logger.debug "----- NEW ABSTRACT COMPONENT '#{self.identifier}'"
      @value ||= nil
    end

    def identifier
      @name
    end

    def value
      @value ||= nil
      execute!
      @value
    end

    def closure
      @block
    end

    def options
      @options
    end
  
    protected
    def option_for(k)
      @options[k] #  && @component_options[k]
    end

    def delete_option(k,&blk)
      @options.delete(k,&blk)
    end

    def execute!(opts={})
      closure_parameters = self.options.merge(opts)
      @value = instance_exec closure_parameters, &closure
    end
  end
end

