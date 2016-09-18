class News < ApplicationRecord
  has_attached_file :image, :styles => { :large => "600x600>", :medium => "320x250>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :title, presence: true
  validates :summary, presence: true
  validates :summary, length: { maximum: 250 }
  validates :content, presence: true

  def self.latest_news(current_article)
    latest_news = []
    order(created_at: :desc).each do |news|
      next if news == current_article
      if latest_news.length < 5
        latest_news << news
      end
    end
    latest_news
  end

end
