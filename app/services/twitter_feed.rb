class TwitterFeed
  attr_reader :feed, :client, :user

  def initialize(user = 'wreccleshamfc')
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = Rails.application.secrets.consumer_key
      config.consumer_secret = Rails.application.secrets.consumer_secret
      config.access_token = Rails.application.secrets.access_token
      config.access_token_secret = Rails.application.secrets.access_secret
    end
    @user = @client&.user(user)
    @feed = @client&.user_timeline(user)
  end

  def own_tweets
    feed.reject do |tweet|
      retweet?(tweet.text) || direct_message?(tweet.text)
    end
  end

  private

  def retweet?(text)
    text.start_with?("RT")
  end

  def direct_message?(text)
    text.start_with?('@')
  end
end
