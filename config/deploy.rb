require "bundler/capistrano"

set :application, "sdruby.org"
set :repository,  "git://github.com/mokolabs/sdruby.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/www/apps/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :branch, "rails3"
set :deploy_via, :remote_cache

# role :app, :application
# role :web, :application
# role :db,  :application, :primary => true
role :app, "8.17.171.89"
role :web, "8.17.171.89"
role :db,  "8.17.171.89", :primary => true

set :user, "admin"

after  'deploy:update_code',  'deploy:symlink_configs'

namespace :deploy do
  desc "Symlinks the database and mongrel cluster configs"
  task :symlink_configs, :roles => [:web] do 
    symlink_database_config
    symlink_images
    symlink_video
  end
  
  desc "Link to the shared database.yml."
  task :symlink_database_config, :roles => [:web] do
    run "rm -f #{latest_release}/config/database.yml"
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end

  desc "Link images to production"
  task :symlink_images, :roles => [:web] do
    # Podcast screenshots
    run "rm -f #{latest_release}/public/images/screenshots"
    run "ln -nfs #{shared_path}/system/screenshots #{latest_release}/public/images/screenshots"
    # Member avatars
    run "rm -f #{latest_release}/public/images/users/avatars"
    run "ln -nfs #{shared_path}/system/avatars #{latest_release}/public/images/users/avatars"
  end

  desc "Link videos"
  task :symlink_video, :roles => [:web] do
    run "ln -nfs  #{shared_path}/system/video #{latest_release}/public/video"
  end
  
  desc "Restart application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end
