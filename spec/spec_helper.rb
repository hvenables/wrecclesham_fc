# frozen_string_literal: true

require 'simplecov'
SimpleCov.start('rails')
require 'coveralls'
Coveralls.wear!('rails')

RSpec.configure do |config|
  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/"])
  end

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before do
    allow(Twitter::REST::Client).to receive(:new)
  end
end
