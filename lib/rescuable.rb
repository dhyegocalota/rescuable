require 'active_support/concern'
require 'active_support/hash_with_indifferent_access'
require 'active_support/lazy_load_hooks'
require 'active_support/dependencies/autoload'

module Rescuable
  extend ActiveSupport::Autoload

  autoload :Error
  autoload :RecordError
  autoload :Version

  module Helpers
    extend ActiveSupport::Autoload

    autoload :RendererController
  end
end

if defined?(::Rails)
  require 'rescuable/rails'
else
  I18n.load_path += Dir.glob(File.dirname(__FILE__) + '/../config/locales/*.{rb,yml}')
end
