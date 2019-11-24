require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module FinalProject
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    # config.load_defaults 6.0

    # Configuration to allow API calls from the front end.
    # config.middleware.insert_before 0, Rack::Cors do
    #   allow do
    #     origins 'http://localhost:8080'

    #     resource '*',
    #       headers: :any,
    #       credentials: %w(access-token expiry token-type uid client),
    #       methods: [:get, :post, :put, :patch, :delete, :options, :head]
    #   end
    # end

    # Forces https.
    # config.force_ssl = true

    # Whitelists the front-end server for cross-site requests.
    config.middleware.insert_before 0, Rack::Cors do
      allow do
         origins 'http://localhost:8080'
         resource '*', :headers => :any, :methods => [:get, :post, :delete, :options], credentials: true, expose: ['X-CSRF-Token']
      end

      allow do
        origins '*.ngrok.io'
        resource '*', :headers => :any, :methods => [:get, :post, :delete, :options], credentials: true, expose: ['X-CSRF-Token']
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end