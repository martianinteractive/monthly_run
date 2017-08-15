lock "3.8.2"

set :application, "monthly_run"
set :repo_url, "git@github.com:martianinteractive/monthly_run.git"
set :deploy_to, "/var/www/monthly_run"

set :rvm_ruby_version, '2.3.3'

append :linked_files, "config/database.yml", "config/secrets.yml", "config/application.yml"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

set :passenger_restart_with_touch, true
