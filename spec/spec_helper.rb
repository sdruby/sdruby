# This file is copied to ~/spec when you run 'ruby script/generate rspec'
# from the project root directory.
ENV["RAILS_ENV"] = "test"

require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require "rspec/rails"
require "rspec/autorun"

require "capybara/rspec"
require "authlogic/test_case"

# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.use_transactional_fixtures = true
  config.fixture_path = Rails.root + '/spec/fixtures/'

  ## Configure VCR Cassettes
  VCR.config do |c|
    c.cassette_library_dir = Rails.root.join("spec/vcr_cassettes")
    c.stub_with :webmock # or :fakeweb
  end

  # Includes
  config.include(Authlogic::TestCase)
  config.include(FactoryGirl::Syntax::Methods)

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

