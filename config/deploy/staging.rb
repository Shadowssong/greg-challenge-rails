set :rails_env, 'staging'
set :unicorn_env, 'staging'
set :app_env, 'staging'
set :domain, '10.24.103.50'
role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db, domain, primary: true

server domain, :app, :web, :db
set :branch, "staging"
