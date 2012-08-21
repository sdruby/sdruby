source "https://rubygems.org"

gem "rails", "~> 3.2.8"
gem "rake"

gem "authlogic"
gem "chronic"
gem "dynamic_form"
gem "formatize"
gem "haml-rails"
gem "headliner"
gem "heroku_san"
gem "hpricot"
gem "jquery-rails"
gem "newrelic_rpm"
gem "paperclip", "~> 2.4.5"
gem "progress_bar"
gem "rack-recaptcha", :require => "rack/recaptcha"
gem "rMeetup"
gem "seed_dump"
gem "sunspot_rails"
gem "sunspot_solr"
gem "will_paginate"

group :assets do
  gem "coffee-rails", "~> 3.2.1"
  gem "sass-rails",   "~> 3.2.3"
  gem "uglifier",     ">= 1.0.3"
end

group :development do
  gem "mysql2"
  gem "sqlite3"
  gem "ruby-debug",   platforms: :ruby_18
  gem "ruby-debug19", platforms: :ruby_19
end

group :test do
  gem "faker"
  gem "factory_girl_rails", "~> 1.6.0"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "vcr"
  gem "webmock"
  gem "capybara"
  gem "capybara-firebug"
  gem "spork", "~> 1.0rc"
  gem "database_cleaner"
end

group :development, :test do
  gem "guard"
  gem "guard-spork"
  gem "guard-rspec"
  gem "launchy"
end

group :heroku do
  gem 'pg'
end
