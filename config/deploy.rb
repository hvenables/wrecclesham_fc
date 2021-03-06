# frozen_string_literal: true

lock '3.11.0'

set :application, 'wrecclesham'
set :repo_url, 'git@github.com:hvenables/wrecclesham_fc.git'

set :branch, ENV['REF'] || 'master'

set :deploy_to, '/var/www/wrecclesham'

# Symlink files and dirs
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

## RVM settings
set :rvm1_ruby_version, '2.5.0'
set :rvm1_map_bins, fetch(:rvm1_map_bins) + %w[gem bundle ruby rake]

set :whenever_identifier, -> { "#{fetch(:application)}_#{fetch(:stage)}" }
