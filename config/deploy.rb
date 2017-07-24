# frozen_string_literal: true

# config valid only for Capistrano 3.1
lock '3.8.2'

set :application, 'wrecclesham'
set :repo_url, 'git@github.com:hvenables/wrecclesham_fc.git'

# Load branch/tag/commit from REF env var, otherwise use master
set :branch, ENV['REF'] || 'master'
set :user,   'deploy'

# Default deploy_to directory is /var/www/my_app
set :deploy_to, 'apps/wrecclesham'

# Symlink files and dirs
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system')
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

## RVM settings
set :rvm1_ruby_version, '2.3.1'
set :rvm1_map_bins, fetch(:rvm1_map_bins) + %w[gem bundle ruby rake]
