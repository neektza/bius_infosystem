load 'deploy/assets'
require 'bundler/capistrano'

set :application, "infosystem.bius.hr"
set :repository,  "git@github.com:neektza/bius_infosystem.git"
set :deploy_to, "/home/bius/infosystem.bius.hr" 

set :scm, :git
set :user, 'bius'
set :use_sudo, false

set :branch, "master"
set :deploy_via, :remote_cache

ssh_options[:forward_agent] = true

role :web, "hosting.kset.org"
role :app, "hosting.kset.org"
#role :db,  "db.kset.org", :primary => true # This is where Rails migrations will run

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
