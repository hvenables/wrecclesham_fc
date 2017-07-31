# frozen_string_literal: true

require 'rails_helper'

RSpec.describe News do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to validate_presence_of(:content) }

  context '#latest_news' do
    6.times do |n|
      let!("news_#{n}".to_sym) do
        Timecop.travel(-n.day) do
          create :news
        end
      end
    end

    it 'gets the last 5 news articles by date except for itself' do
      expect(News.latest_news(news_0)).to eq [news_1, news_2, news_3, news_4]
    end
  end
end
