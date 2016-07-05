class News < ApplicationRecord
  validates :title, presence: true
  validates :summary, presence: true
  validates :summary, length: { maximum: 250 }
  validates :content, presence: true
end
