source :rubygems

gem "rails", "3.1.3"
gem "rake", "0.8.7"

gem "authlogic"
gem "chronic"
gem "dynamic_form"
gem "haml"
gem "hpricot"
gem "jquery-rails"
gem "mysql2", :git => "git://github.com/sdruby/mysql2.git", :branch => "master"
gem "newrelic_rpm"
gem "paperclip"
gem "rack-recaptcha", :require => "rack/recaptcha"
gem "will_paginate"
gem "formatize"
gem 'yaml_db'

gem "sass"

# TODO: Pending move to Heroku...
# group :assets do
#   gem "coffee-rails", "~> 3.1.1"
#   gem "sass-rails",   "~> 3.1.5"
#   gem "uglifier", ">= 1.0.3"
# end

group :development do
  gem "sqlite3"
  gem "ruby-debug", platforms: :ruby_18
  gem "ruby-debug19", platforms: :ruby_19
end

group :test do
  gem "faker"
  gem "factory_girl_rails"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "vcr"
  gem "webmock"
  gem "capybara"
  gem "spork", "~> 1.0rc"
end

group :development, :test do
  gem "guard"
  gem "guard-spork"
  gem "guard-rspec"
end
