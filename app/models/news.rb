class News < ApplicationRecord
  has_attached_file :image, :styles => { :large => "600x600>", :medium => "320x250>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

  validates :title, presence: true
  validates :summary, presence: true
  validates :summary, length: { maximum: 250 }
  validates :content, presence: true
end
