namespace :db do

  desc "Creates database schema and loads fixtures"
  task :bootstrap => ["db:migrate", "db:bootstrap:load"]

  namespace :bootstrap do

    desc "Loads a schema.rb file into the database and then loads the initial database fixtures."
    task :load => :environment do
      require 'active_record/fixtures'
      ActiveRecord::Base.establish_connection(Rails.env.to_sym)
      # Load fixtures
      (ENV['FIXTURES'] ? ENV['FIXTURES'].split(/,/) : Dir.glob(File.join(Rails.root, 'db', 'bootstrap', '*.{yml,csv}'))).each do |fixture_file|
        Fixtures.create_fixtures('db/bootstrap', File.basename(fixture_file, '.*'))
        puts "Loaded bootstrap fixture file #{File.basename(fixture_file, '.*')}"
      end
    end

    desc "Resets the database using migrations and loads the boostrap data"
    task :reset => ["db:migrate:reset", "db:bootstrap:load"]
	end
end
