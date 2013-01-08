source "https://rubygems.org"
ruby "1.9.3"

gem "rails", "~> 3.2.11"
gem "rake"

gem "authlogic"
gem "aws-sdk"
gem "chronic"
gem "dynamic_form"
gem "formatize"
gem "haml-rails"
gem "headliner"
gem "heroku_san"
gem "hpricot"
gem "jquery-rails"
gem "newrelic_rpm"
gem "paperclip", "~> 3.1.4"
gem "progress_bar"
gem "rack-recaptcha", require: "rack/recaptcha"
gem "rMeetup", require: "rmeetup"
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
  gem "quiet_assets"
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
  gem "sqlite3"
end

group :heroku do
  gem "pg"
  gem "thin"
end
