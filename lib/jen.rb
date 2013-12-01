require 'active_support/all'
require 'securerandom'

require 'jen/version'

require 'jen/abstract_component'

require 'jen/extensions'
require 'jen/attribute'
require 'jen/reflect'

require 'jen/factory/registry'
require 'jen/factory/construction'
require 'jen/factory/traits'
require 'jen/factory/base'
require 'jen/factory/aspect'

require 'jen/dsl'

module Jen
  include Reflect
  include DSL
end
