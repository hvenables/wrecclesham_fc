source 'https://rubygems.org'

ruby '2.3.1'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.0'
# Use postgresql as the database for Active Record
gem 'pg', '~> 0.18'
# Use Puma as the app server
gem 'puma'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'redcarpet'
gem 'pygments.rb'

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

gem 'nokogiri', '~> 1.6', '>= 1.6.7.2'

gem 'haml-rails', '~> 0.9.0'

gem 'devise', :github => "plataformatec/devise"

# Adding images
gem 'paperclip'

# Adding aws storage
gem 'aws-sdk'

#Calculating time differences
gem 'time_difference'

# permissions
gem 'cancancan', '~> 1.15'

gem 'yt'

# caching storage
gem 'dalli'

# Error reporting
gem 'rollbar'
gem "jquery-slick-rails"
# running cron jobs
gem 'whenever', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'pry-rails'
  gem 'pry'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'
  gem 'listen', '~> 3.0.5'
  gem 'spring-commands-rspec'
  gem 'erb2haml', '~> 0.1.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'capistrano',         require: false
  gem 'capistrano-rvm',     require: false
  gem 'capistrano-rails',   require: false
  gem 'capistrano-bundler', require: false
  gem 'capistrano3-puma',   require: false
end

group :test do
  gem 'rspec-rails'
  gem 'capybara'
  gem 'shoulda-matchers', '~> 3.1', '>= 3.1.1'
  gem 'shoulda'
  gem 'factory_girl_rails', :github => 'thoughtbot/factory_girl_rails'
  gem 'coveralls', require: false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
