require 'rescuable/rails/renderer_controller'

module Rescuable
  class Engine < ::Rails::Engine
    initializer 'rescuable.locales' do |app|
      if app.config.i18n.fallbacks.blank?
        app.config.i18n.fallbacks = [:en]
      end
    end

    initializer 'rescuable.helpers' do
      ActiveSupport.on_load(:action_controller) do
        include Rescuable::Rails::RendererController
      end
    end
  end
end
