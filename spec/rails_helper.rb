# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../config/environment', __dir__)
require 'rspec/rails'
require 'support/devise/test_helpers'
require 'support/video_helpers'
Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }
require 'webmock/rspec'
require 'capybara/rails'

WebMock.disable_net_connect!(allow_localhost: true)

Capybara.server = :puma, { Silent: true }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium_chrome_headless
  end

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.include DeviseTestHelpers
  config.include VideoHelper
  config.include FeatureMatchers

  config.include FactoryBot::Syntax::Methods
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
