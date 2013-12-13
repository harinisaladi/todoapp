require 'bundler/capistrano'
require 'rvm/capistrano'

set :application, "todoapp"
set :repository,  "git@github.com:harinisaladi/todoapp.git"
#set :rvm_ruby_string, :local
#set :deploy_to, "/var/www/todoapp.com"
set :scm, :git
set :branch, "master"
set :user, "lumoid"
set :use_sudo, false
set :rails_env, "staging"
set :deploy_via, :copy
set :keep_releases, 3
set :bundle_flags,    ""

default_run_options[:pty] = true
server "ec2-54-201-171-168.us-west-2.compute.amazonaws.com", :app, :web, :db, :primary => true
set :deploy_to, "/home/lumoid/todoapp"

namespace :deploy do
  task :start do ; end
  task :stop do ; end

  desc "Restart applicaiton"
  task :restart do
    run "#{ try_sudo } touch #{ File.join(current_path, 'tmp', 'restart.txt') }"
  end
end

after "deploy", "deploy:restart"
after "deploy", "deploy:cleanup"
