# frozen_string_literal: true

class News < ApplicationRecord
  has_attached_file :image,
                    styles: { large: '600x600>', medium: '320x250>', thumb: '100x100>' },
                    default_url: '/images/:style/missing.png',
                    s3_protocol: :https
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  paginates_per 9

  validates :title, :image, :content, presence: true

  scope :latest_news, ->(current_article) { where.not(id: current_article.id).order(created_at: :desc).limit(4) }
end
