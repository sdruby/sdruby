set :application, "new.sdruby.com"
set :repository,  "git://github.com/mokolabs/sdruby.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/home/admin/www/public/#{application}"

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

role :app, "new.sdruby.com"
role :web, "new.sdruby.com"
role :db,  "new.sdruby.com", :primary => true

set :user, "admin"
set :password, "LaHorviaQuecyec2"
