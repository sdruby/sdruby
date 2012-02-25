require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  Bundler.require(*Rails.groups(:assets => %w(development test)))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
end

module SDRuby
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'UTC'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password, :password_confirmation]

    # Enable the asset pipeline
    config.assets.enabled = false  # TODO: Turning back one when we move to Heroku...

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.0'

    # config.assets.precompile += ['iphone.css', 'jquery-1.3.2.min.js', 'iphone-style-checkboxes.js']

    # Recaptcha
    unless Rails.env.test?
      config.middleware.use Rack::Recaptcha, 
        :public_key => '6LdJOMASAAAAAFZDpwMtiQLz_J4yZ5PqaGRlJ2dQ', 
        :private_key => '6LdJOMASAAAAABY7abzfkCSBFOz94yd-sVF8RBvn', 
        :paths => '/users'
    end

    # Configure Tools
    config.generators do |g|
      g.orm :active_record
      g.template_engine :haml
      g.test_framework :rspec, :fixture => true, :views => false
      g.integration_tool :rspec, :dir => "spec/acceptance"
      g.fixture_replacement :factory_girl, :dir => "spec/factories"
      g.stylesheets false
      g.javascripts false
    end
  end
end
