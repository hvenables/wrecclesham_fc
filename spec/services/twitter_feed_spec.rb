# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TwitterFeed, type: :service do
  subject(:wrecclesham_tweets) { TwitterFeed.own_tweets }

  let!(:twitter_feed) do
    [
      OpenStruct.new(text: 'Two good results and 17 goals across two games this afternoon! Keep an eye out for those match reports'),
      OpenStruct.new(text: 'RT @Woking_Horsell: A Team lost 3-1 to @WreccleshamFC on to next game'),
      OpenStruct.new(text: '@calmcroyall thank you Caroline!'),
      OpenStruct.new(text: "Match Report vs Bourne Blades (League Invitational Cup)\n\nRemember to like and share... https://t.co/PzNiKUZtxg")
    ]
  end

  before do
    allow_any_instance_of(TwitterFeed).to receive(:feed).and_return(twitter_feed)
  end

  scenario "Will only return tweets; no retweets or DM's" do
    expect(wrecclesham_tweets.length).to eq 2
    expect(wrecclesham_tweets[0]).to eq '<p>Two good results and 17 goals across two games this afternoon! Keep an eye out for those match reports</p>'
    expect(wrecclesham_tweets[1]).to eq "<p>Match Report vs Bourne Blades (League Invitational Cup)</p>\n\n<p>Remember to like and share... <a href=\"https://t.co/PzNiKUZtxg\">https://t.co/PzNiKUZtxg</a></p>"
  end
end
