load 'deploy/assets'
require 'bundler/capistrano'

set :default_environment, {
  'PATH' => "/home/bius/.rbenv/shims:/home/bius/.rbenv/bin:$PATH"
}

set :application, "infosystem.bius.hr"
set :repository,  "git@github.com:neektza/bius_infosystem.git"
set :deploy_to, "/home/bius/infosystem.bius.hr" 

set :scm, :git
set :user, 'bius'
set :use_sudo, false

set :branch, "master"
set :deploy_via, :remote_cache

ssh_options[:forward_agent] = true

server 'hosting.kset.org', :web, :app
# role :db,  "hosting.kset.org", :primary => true
# role :db,  "db.kset.org", :no_release => true

after 'deploy:update_code', 'deploy:symlink_db'

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :symlink_db, :roles => :app do
    run "ln -nfs #{deploy_to}/shared/config/database.yml #{release_path}/config/database.yml"
  end
end
