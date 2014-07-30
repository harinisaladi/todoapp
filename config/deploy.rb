require 'bundler/capistrano'

set :application, "todoapp"
set :repository,  "git@github.com:harinisaladi/todoapp.git"
#set :rvm_ruby_string, :local
#set :deploy_to, "/var/www/todoapp.com"
set :scm, :git
set :branch, "master"
set :user, "lumoid"
ssh_options[:keys] = %w(~/.ssh/id_rsa.pub)
set :use_sudo, false
set :rails_env, "staging"
set :deploy_via, :copy
set :keep_releases, 3
set :bundle_flags,    ""

default_run_options[:pty] = true
set :ssh_options, {:forward_agent => true}

server "54.225.225.142", :app, :web, :db, :primary => true
set :deploy_to, "/home/master/lumoid/staging"

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
