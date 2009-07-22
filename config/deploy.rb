set :application, "new.sdruby.com"
set :repository,  "git://github.com/mokolabs/sdruby.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/admin/www/public/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git
set :branch, "master"
set :deploy_via, :remote_cache

role :app, "new.sdruby.com"
role :web, "new.sdruby.com"
role :db,  "new.sdruby.com", :primary => true

set :user, "admin"
set :mongrel_config, "#{current_path}/config/mongrel_cluster.yml"

after  'deploy:update_code',  'deploy:symlink_configs'

namespace :deploy do
  desc "Symlinks the database and mongrel cluster configs"
  task :symlink_configs, :roles => [:web] do 
    symlink_database_config
    symlink_mongrel_cluster_config
    symlink_images
    symlink_video
  end
  
  desc "Link to the shared database.yml."
  task :symlink_database_config, :roles => [:web] do
    run "rm -f #{latest_release}/config/database.yml"
    run "ln -nfs #{shared_path}/config/database.yml #{latest_release}/config/database.yml"
  end

  desc "Link to the shared mongrel_cluster.yml."
  task :symlink_mongrel_cluster_config, :roles => [:web] do
    run "rm -f #{latest_release}/config/mongrel_cluster.yml"
    run "ln -nfs #{shared_path}/config/mongrel_cluster.yml #{latest_release}/config/mongrel_cluster.yml"
  end

  desc "Link images to production"
  task :symlink_images, :roles => [:web] do
    run "rm -f #{latest_release}/public/images/screenshots"
    run "ln -nfs #{shared_path}/system/screenshots #{latest_release}/public/images/screenshots"
  end

  desc "Link videos"
  task :symlink_video, :roles => [:web] do
    run "ln -nfs  /home/admin/www/public/new.sdruby.com/shared/system/video #{latest_release}/public/video"
  end
  
  desc "Restart mongrel_cluster(which restarts rails)"
  task :restart do
    run "mongrel_rails cluster::restart -C #{mongrel_config}"
  end

  desc "Cold deploy start mongrel_cluster(which restarts rails)"
  task :start do
    run "mongrel_rails cluster::start -C #{mongrel_config}"
  end
end
