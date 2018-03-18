# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.5.0'

gem 'rails'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma', '~> 3.8.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem 'pygments.rb'

gem 'redcarpet'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5.x'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem 'simple_chartjs'

gem 'nokogiri', '~> 1.6', '>= 1.6.7.2'

gem 'haml-rails'

gem 'devise'

gem 'bootstrap'

source 'https://rails-assets.org' do
  gem 'rails-assets-tether', '>= 1.3.3'
end
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.1'

# Adding images
gem 'paperclip'

# Adding aws storage
gem 'aws-sdk-s3'

# Calculating time differences
gem 'time_difference'

# permissions
gem 'cancancan', '~> 1.15'

gem 'yt'

# caching storage
gem 'dalli'

# Error reporting
gem 'jquery-slick-rails'
gem 'rollbar'
# running cron jobs
gem 'whenever', require: false

# pagination
gem 'kaminari'

gem 'twitter', '~> 5.16'

gem 'rails_autolink'

# Speeds up boot time by caching require calls
gem 'bootscale'

# Prodection from bad clients
gem 'rack-attack'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry'
  gem 'pry-rails'
  gem 'rb-readline'
end

group :development do
  gem 'listen', '~> 3.0.5'
  gem 'spring-commands-rspec'
  gem 'web-console', '~> 3.0'
  gem 'capistrano', require: false
  gem 'rvm1-capistrano3', require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano-rails', require: false
  gem 'capistrano3-puma', require: false
  gem 'rubocop', require: false
  gem 'rack-mini-profiler'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'haml_lint', require: false
  gem "better_errors"
  gem "binding_of_caller"
end

group :test do
  gem 'rack-test', '~> 0.7.0'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'coveralls', require: false
  gem 'simplecov', require: false
  gem 'timecop'
  gem 'webmock'
end
