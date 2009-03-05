require 'migration_helper'

namespace :db do
  namespace :migrate do

    desc 'Migrates podcasts'
    task :podcasts => :environment do
      migrate :podcasts
    end
    
	end
end