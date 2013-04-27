require "bundler/capistrano"
require "rvm/capistrano"

server "192.168.2.1", :web, :app

set :application, "rss_reading"
set :user, "deployer"
set :deploy_to, "/var/www/deployer/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :rvm_ruby_string, "1.9.3@#{application}"
set :rvm_install_type, :stable

set :scm, :git
set :repository, "git@github.com:pablodv/#{application}.git"
set :branch, "master"

before "deploy:setup", "rvm:install_rvm"
before "deploy:setup", "rvm:install_ruby"
before "deploy:setup", "rvm:create_gemset"

after "deploy:update_code", "deploy:migrate"
after "deploy:migrate", "elasticsearch:index_classes"
after "elasticsearch:index_classes", "deploy:cleanup"

namespace :deploy do
  desc "Restart the application"
  task :restart, roles: :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end

  after "deploy:finalize_update", "deploy:symlink_shared"
end

namespace :elasticsearch do
  desc 'run elasticsearch indexing via tire'
  task :index_classes do
    run "cd #{deploy_to}/current && bundle exec rake environment tire:import:all FORCE=true"
  end
end
