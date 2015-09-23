require 'active_support/concern'
require 'active_support/hash_with_indifferent_access'
require 'active_support/lazy_load_hooks'
require 'active_support/dependencies/autoload'

module Rescuable
  extend ActiveSupport::Autoload

  autoload :Error
  autoload :RecordError
  autoload :Version
end

require 'rescuable/engine'
