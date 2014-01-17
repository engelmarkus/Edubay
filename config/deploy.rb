set :rvm_ruby_string, "2.1.0@edubay"
set :rvm_type, :system

# Deploy user
set :user, "engel"

set :application, "edubay"
set :deploy_to, "/var/www/edubay"

set :scm, :git
set :repo_url,  'git@github.com:engelmarkus/Edubay.git'
set :branch, "master"
set :scm_username, "engelmarkus"
set :deploy_via, :remote_cache
set :scm_verbose, true
