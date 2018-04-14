# frozen_string_literal: true

class TwitterFeed
  attr_reader :feed, :client, :user

  def self.own_tweets
    new.own_tweets
  end

  private_class_method :new
  def initialize(user = 'wreccleshamfc')
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.secrets.consumer_key
      config.consumer_secret = Rails.application.secrets.consumer_secret
      config.access_token = Rails.application.secrets.access_token
      config.access_token_secret = Rails.application.secrets.access_secret
    end

    @user = @client&.user(user)
    @feed = @client&.user_timeline(user) || []
  end

  def own_tweets
    feed
      .reject { |tweet| retweet?(tweet.text) || direct_message?(tweet.text) }
      .map do |tweet|
        ActionController::Base
          .helpers
          .simple_format(tweet.text)
          .yield_self { |text| ActionController::Base.helpers.auto_link(text) }
      end
  end

  private

  def retweet?(text)
    text.start_with?('RT')
  end

  def direct_message?(text)
    text.start_with?('@')
  end
end
