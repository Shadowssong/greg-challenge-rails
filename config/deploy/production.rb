set :rails_env, 'production'
set :unicorn_env, 'production'
set :app_env, 'production'
set :domain, '192.168.1.9'
role :web, domain                          # Your HTTP server, Apache/etc
role :app, domain                          # This may be the same as your `Web` server
role :db, domain, primary: true

server domain, :app, :web, :db
set :branch, "master"
