require File.expand_path('../boot', __FILE__)

require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Jambo
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'
    config.autoload_paths += %W(
      #{config.root}/lib
      #{config.root}/lib/**
      #{config.root}/models/concerns
      #{config.root}/app/models/drops
      #{config.root}/app/serializers
    )

    # Require the core class extensions
    Dir[File.join(Rails.root, "lib", "core_ext", "*.rb")].each { |l| require l }

    # config.middleware.use Rack::Cors do
    #   allow do
    #     origins '*'
    #     resource '*',
    #       :headers => :any,
    #       :expose  => ['jambo-api-token', 'wishpond-api-token', 'wishmail-api-token'],
    #       :methods => [:get, :post, :options, :delete, :put]
    #   end
    # end

    # # Lets cache stuff with Redis
    # config.cache_store = :redis_store, {
    #   host: ENV["REDIS_HOST"] || "localhost",
    #   port: ENV["REDIS_PORT"] || 6379,
    #   db: 0,
    #   namespace: "jambo-cache",
    #   expires_in: 90.minutes
    # }

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de
  end
end
