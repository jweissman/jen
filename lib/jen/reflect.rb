module Jen
  module Reflect
    def singular_and_plural_methods(meth)
      method_name = meth.to_s
      method_name.singular_and_plural.map(&:to_sym)
    end

    def detect_singular_or_plural(list,meth)
      singular_and_plural_methods(meth).detect do |method_name|
	list.include? method_name
      end
    end

    def detect_instance_method(klass, m)
      detect_singular_or_plural(klass.instance_methods, m)
    end
  end
end
