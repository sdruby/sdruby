require 'rubygems'
require 'spork'
#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.

  # This file is copied to ~/spec when you run 'ruby script/generate rspec'
  # from the project root directory.
  ENV["RAILS_ENV"] = "test"

  require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
  require "rspec/rails"
  require "rspec/autorun"

  require "capybara/rspec"
  require "capybara/firebug"

  # Requires supporting files with custom matchers and macros, etc,
  # in ./support/ and its subdirectories.
  Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

  RSpec.configure do |config|
    config.use_transactional_fixtures = false  # Using database_cleaner instead...
    config.fixture_path = Rails.root + '/spec/fixtures/'

    ## Configure VCR Cassettes
    VCR.configure do |c|
      c.cassette_library_dir = Rails.root.join("spec/vcr_cassettes")
      c.hook_into :webmock # or :fakeweb
      c.ignore_localhost = true
    end

    # Includes
    config.include(FactoryGirl::Syntax::Methods)

    # Stubing Solr
    Sunspot.session = Sunspot::Rails::StubSessionProxy.new(Sunspot.session)
  end
end

Spork.each_run do
  # This code will be run each time you run your specs.

end

