# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'wrecclesham'
set :repo_url, 'git@github.com:hvenables/wrecclesham_fc.git'

# Default branch is :master
# set :branch, 'master'

# Default deploy_to directory is /var/www/my_app
set :deploy_to, '/var/www/wreccleshamfc'

# Default value for :linked_files is []
set :linked_files, %w(config/database.yml config/secrets.yml config/puma.rb) # config/secrets.yml

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system', 'solr/default', 'solr/pids')
# set :keep_releases, 100

# RVM settings
set :rvm1_ruby_version, "2.3.1"
# set :rvm1_map_bins, fetch(:rvm1_map_bins) + %w{passenger passenger-config}
set :rvm1_map_bins, fetch(:rvm1_map_bins).to_a.concat(%w(sidekiq sidekiqctl))

set :skip_git_changes_notifications, true

# set :whenever_identifier, ->{ "#{fetch(:application)}_#{fetch(:stage)}" }

set :rollbar_token, '9a918bda382940c78383a2467fd56704'

namespace :deploy do
  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end
end
