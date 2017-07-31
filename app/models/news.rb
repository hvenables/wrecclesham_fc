# frozen_string_literal: true

class News < ApplicationRecord
  has_many :images, as: :subject, inverse_of: :subject

  paginates_per 9

  validates :title, :content, :images, presence: true

  accepts_nested_attributes_for :images

  scope :latest_news, ->(current_article) { where.not(id: current_article.id).order(created_at: :desc).limit(4) }
end
