require 'bundler/capistrano'

set :application, "redmine"
set :stages, %w(production staging)
set :default_stage, "staging"

require 'capistrano/ext/multistage'

set :user, "challenge"
set :group, "challenge"
set :deploy_to, "/home/challenge/#{application}"
set :use_sudo, false

default_run_options[:pty] = true

set :scm, :git
set :deplyoy_via, :remote_cache
set :repository, "git@github.com:Shadowssong/greg-challenge-rails.git"
set :ssh_options, { :forward_agent => true }

namespace :deploy do

  task :default do
    update
    restart
  end

  desc "Zero-downtime restart of Unicorn"
  task :restart, roles: :app, except: { no_release: true } do
    run "kill -s USR2 `cat /tmp/#{application}.pid`"
  end

  desc "Start unicorn"
  task :start, roles: :app, except: { no_release: true } do
    run "cd #{current_path} ; RAILS_ENV=#{rails_env} bundle exec unicorn -c #{current_path}/config/unicorn.rb -D"
  end

  desc "Stop unicorn"
  task :stop, roles: :app, except: { no_release: true } do
    run "if [ -f /tmp/#{application}.pid ] && [ -e /proc/`cat /tmp/#{application}.pid` ]; then kill -s QUIT `cat /tmp/#{application}.pid`; fi"
  end
end
