# frozen_string_literal: true

require 'simplecov'
SimpleCov.start('rails')
require 'coveralls'
Coveralls.wear!('rails')

require 'support/factory_girl'
require 'support/devise/test_helpers'
require 'support/video_helpers'
require 'webmock/rspec'
require 'support/database_cleaner'

WebMock.disable_net_connect!(allow_localhost: true)
Capybara.javascript_driver = :headless_chrome

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless disable-gpu] }
  )

  Capybara::Selenium::Driver.new(
    app,
    browser: :chrome,
    desired_capabilities: capabilities
  )
end

RSpec.configure do |config|
  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/"])
  end

  config.include DeviseTestHelpers
  config.include VideoHelper
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:each) do
    allow(Twitter::REST::Client).to receive(:new)
  end

  config.include FactoryBot::Syntax::Methods
end
