require 'rails_helper'

RSpec.describe News, type: :model do
  10.times do |n|
    let!("news_#{n}".to_sym) do
      Timecop.travel(-n.day) do
        create :news
      end
    end
  end

  context '#latest_news' do
    it 'gets the last 5 news articles by date except for itself' do
      expect(News.latest_news(news_1)).to eq [news_2, news_3, news_4, news_5, news_6]
    end
  end
  
end
