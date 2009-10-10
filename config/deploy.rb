set :application, "lamestuff.com"
set :repository,  "svn+ssh://lamestuff.com/svn/lamestuff.com/trunk"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_base, "/home/lamestuff/"
set :deploy_via, :export

set :use_sudo, false

# If you aren't using Subversion to manage your source code, specify
# your SCM below:
# set :scm, :subversion

set :runner , 'lamestuff'
set :user, 'lamestuff'

role :app, "lamestuff.com"
role :web, "lamestuff.com"
role :db,  "lamestuff.com", :primary => true

# passenger stuff:

namespace :passenger do
  desc "Restart Application"
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

after :deploy, "passenger:restart"
