require "database_cleaner"

RSpec.configure do |config|
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation if example.metadata[:js]
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
    DatabaseCleaner.strategy = :transaction if example.metadata[:js]
  end
end


