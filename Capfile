load 'deploy'
# Uncomment if you are using Rails' asset pipeline
load 'deploy/assets'

load 'config/deploy' # remove this line to skip loading any of the default tasks

# Copy database.yml and edubay.yml from user directory
namespace :db do
  task :db_config, except: { no_release: true }, role: :app do
    run "cp -f ~/database.yml #{release_path}/config/database.yml"
    run "cp -f ~/edubay.yml #{release_path}/config/edubay.yml"
  end
end

after "deploy:finalize_update", "db:db_config"