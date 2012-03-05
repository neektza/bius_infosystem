require 'bundler/capistrano'

set :application, "bius_infosystem"
set :repository,  "git@github.com:neektza/bius_infosystem.git"
set :deploy_to, "TODO" 

set :scm, :git
set :user, 'woot'
set :use_sudo, false

set :branch, "master"
set :deploy_via, :remote_cache

role :web, "hosting.kset.org"
role :app, "hosting.kset.org"
role :db,  "db.kset.org", :primary => true # This is where Rails migrations will run

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
