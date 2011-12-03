source :rubygems

gem 'rails', '3.1.3'

gem 'mysql2'
gem 'jquery-rails'
gem 'haml'
gem 'newrelic_rpm'
gem 'authlogic'
gem 'will_paginate'
gem 'hpricot'
gem 'chronic'
gem 'rack-recaptcha', :require => 'rack/recaptcha'

group :assets do
  gem 'sass-rails',   '~> 3.1.5'
  gem 'coffee-rails', '~> 3.1.1'
  gem 'uglifier', '>= 1.0.3'
end

group :development do
  gem 'ruby-debug', platforms: :ruby_18
  gem 'ruby-debug19', platforms: :ruby_19
end

group :test, :cucumber do
  gem "rspec-rails"
  gem "shoulda"
  gem "faker"
  gem "factory_girl"
  gem "vcr"
  gem "webmock"
end

group :cucumber do
  gem "cucumber"
  gem "cucumber-rails"
  gem "pickle"
  gem "capybara"
  gem "xpath"
  gem "launchy"
end
