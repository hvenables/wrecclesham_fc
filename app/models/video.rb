# frozen_string_literal: true

class Video < ApplicationRecord
  before_save :add_thumbnail

  validates :title, :content, :url, presence: true
  validate :embedable_url
  def embedable_url
    return false if url.blank?
    return if url.include?('embed')
    errors[:link] << 'is not an embedable link please see example'
  end

  def url_santizer
    url.gsub(/^http.?:/im, '') if url[0..3] == 'http'
  end

  def add_thumbnail
    video = Yt::Video.new url: url
    self.thumbnail = video.thumbnail_url('medium')
  end
end
