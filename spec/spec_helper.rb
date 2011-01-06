# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] = "test"

require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require "spec"
require "spec/rails"
require "faker"
require "factory_girl"
require "shoulda"
require "authlogic/test_case"
require "vcr"

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

# Load Factories:
Dir["#{Rails.root}/spec/factories/**/*.rb"].each {|f| require f}

Spec::Runner.configure do |config|
  config.use_transactional_fixtures = true
  config.use_instantiated_fixtures  = false
  config.fixture_path = RAILS_ROOT + '/spec/fixtures/'

  ## Configure VCR Cassettes
  VCR.config do |c|
    c.cassette_library_dir = Rails.root.join("spec/vcr_cassettes")
    c.stub_with :webmock # or :fakeweb
  end

  ## Helpers:
  def logout
    request.session = {'user_credentials' => nil, 'user_credentials_id' => nil}
  end

  def login_as(user)
    activate_authlogic

    user = Factory(user) if user.is_a?(Symbol)
    UserSession.create(user)
  end
end

