require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)
Dotenv.load
# load environment specific variables
Dotenv.overload(".env.#{Rails.env}")

module Deauthorized
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.serve_static_assets = true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Added Active elastic job for Active job
    # config.active_job.queue_adapter = :active_elastic_job

    # Establish Dalli as client for cache store
    config.cache_store = :dalli_store

    config.middleware.use Rack::Attack

    # Config for Doorkeeper
    # config.active_record.whitelist_attributes = false

    # CORS
    config.middleware.use Rack::Cors do
      allow do
        origins '*'
        resource '*',
          :headers => :any,
          :expose  => ['access-token', 'expiry', 'token-type', 'uid', 'client'],
          :methods => [:get, :post, :options, :delete, :put]
      end
    end

    config.autoload_paths << "#{Rails.root}/lib"
    # fix for devise session to persist across sub-domains
    config.session_store :cookie_store, key: '_deauthorized_session', domain: ".#{ENV['DOMAIN']}"

  end
end
