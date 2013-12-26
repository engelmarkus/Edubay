set :rvm_ruby_string, "2.1.0@edubay"
set :rvm_type, :system

#default_run_options[:pty] = true
#ssh_options[:forward_agent] = true

# Deploy user
set :user, "engel"
#set :use_sudo, true

set :application, "edubay"
#set :production_server, "edubay.in.tum.de"
set :deploy_to, "/var/www/edubay"

set :scm, :git
set :repo_url,  'git@github.com:engelmarkus/Edubay.git'
set :branch, "master"
set :scm_username, "engelmarkus"
set :deploy_via, :remote_cache
set :scm_verbose, true

#role :web, application
#role :app, application
#role :db, application

#before "deploy:assets:precompile", "deploy:copy_in_yml_files"
