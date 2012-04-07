require "bundler/capistrano"

# A system wide installation of RVM will be run on the server.
set :rvm_ruby_string, "1.9.2"
set :rvm_type, :system

require "rvm/capistrano"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

# Deploy user
set :user, "engel"
set :use_sudo, true

set :application, "edubay"
set :production_server, "edubay.in.tum.de"
set :deploy_to, "/var/www/edubay"

set :scm, :git
set :repository,  'git@github.com:engelmarkus/Edubay.git'
set :branch, "master"
set :scm_username, "engelmarkus"
set :deploy_via, :remote_cache
set :scm_verbose, true

role :web, production_server
role :app, production_server
role :db, production_server, primary: true

# Make Passenger restart after deployment.
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, roles: :app, except: { no_release: true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
