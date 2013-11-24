require 'bundler/capistrano'
require 'rvm/capistrano'

set :application, "todoapp"
set :repository,  "git@github.com:harinisaladi/todoapp.git"
#set :rvm_ruby_string, :local
#set :deploy_to, "/var/www/todoapp.com"
set :scm, :git
set :branch, "master"
set :user, "ec2-user"
set :use_sudo, false
set :rails_env, "production"
set :deploy_via, :copy
set :ssh_options, :forward_agent => true
set :keep_releases, 3
set :bundle_flags,    ""

default_run_options[:pty] = true
server "ec2-54-193-11-158.us-west-1.compute.amazonaws.com", :app, :web, :db, :primary => true

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  desc "Symlink shared config files"
  task :symlink_config_files do
    run "#{ sudo } ln -s #{ deploy_to }/shared/config/database.yml #{ current_path }/config/database.yml"
  end

  desc "Restart applicaiton"
  task :restart do
    run "#{ try_sudo } touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
  end
end

after "deploy", "deploy:symlink_config_files"
after "deploy", "deploy:restart"
after "deploy", "deploy:cleanup"
