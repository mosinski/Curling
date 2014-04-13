require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  Bundler.require(*Rails.groups(:assets => %w(development test)))
end

module Osp
  class Application < Rails::Application
    I18n.enforce_available_locales = false
    config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :pl
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    config.assets.paths << "#{Rails.root}/app/assets/fonts"
    config.assets.precompile += %w( .svg .eot .woff .ttf )
    config.assets.precompile += ["redactor-rails/*"]
    config.assets.precompile += ["bootstrap/*"]
    config.assets.precompile += ["fancybox/*"]
    config.assets.precompile += ["pwdstr/*"]
    config.assets.precompile += ["share/*"]
    config.assets.enabled = true
    config.assets.version = '1.0'
    config.time_zone = 'Warsaw'
  end
end
