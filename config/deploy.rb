set :application, "lamestuff.com"
set :repository,  "ssh://spike@scm.home.spike.cx/scm/lamestuff.git"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_base, "/home/lamestuff/"
set :deploy_via, :remote_cache
set :deploy_branch, 'master'

set :use_sudo, false

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
set :scm, :git

set :runner , 'lamestuff'
set :user, 'lamestuff'

role :app, "lamestuff.com"
role :web, "lamestuff.com"
role :db,  "lamestuff.com", :primary => true

# passenger stuff:

namespace :deploy do
  task :start do
  end

  task :stop do
  end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{ File.join(current_path, 'tmp','restart.txt') }"
  end
end

#after :deploy, "passenger:restart"
